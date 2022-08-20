using Microsoft.AspNetCore.Mvc;

namespace guitar_backend.Controllers
{
    /// <summary>
    /// Defines payment routes, that are used for making payments in the app. Requires to be signed in.
    /// </summary>
    [Authorize]
    [Route("[controller]")]
    public class PaymentController : Controller
    {
        /// <summary>
        /// BrainTree service, injected by DI, provides the API for BrainTree's payment gateway.
        /// </summary>
        private readonly IBraintreeService _braintreeService;
        /// <summary>
        /// Provides the <c>DbContext</c> used to make queries on the database.
        /// </summary>
        private readonly guitardbContext _db;
        private readonly IUserManager _userManager;
        /// <summary>
        /// Controller constructor, used for DI.
        /// </summary>
        /// <param name="braintreeService">BrainTree service, injected by DI, provides the API for BrainTree's payment gateway.</param>
        /// <param name="db">Provides the <c>DbContext</c> used to make queries on the database.</param>
        public PaymentController(IBraintreeService braintreeService, guitardbContext db, IUserManager userManager)
        {
            this._braintreeService = braintreeService;
            this._db = db;
            this._userManager = userManager;
        }
        /// <summary>
        /// Creates the token used by BrainTree client in order to make purchases by the client.
        /// </summary>
        /// <returns><c>Ok</c> with the created token.</returns>
        [HttpGet("[action]")]
        public IActionResult GetToken()
        {
            return Ok(_braintreeService.GetToken());
        }
        /// <summary>
        /// Makes the purchase.
        /// </summary>
        /// <param name="model">Holds the <c>Product</c> id's that the user wants to buy, and the "nonce" used by BrainTree to perform the purchase.</param>
        /// <returns><c>Ok</c> if the purchase has been made succesfully, otherwise <c>BadRequest</c> with a relevant message.</returns>
        [HttpPost("[action]")]
        public async Task<IActionResult> MakeOrder([FromBody] MakeOrderModel model)
        {
            ICollection<Product> products;
            try
            {
                products = await _db.Products.Where(p => model.productIds.Contains(p.Id) && p.Price != null).ToListAsync();
            }
            catch
            {
                return BadRequest("No such product/s");
            }
            var totalPrice = products.Sum(p => p.Price ?? 0);

            User? user = await _userManager.GetUserFromToken(Request.Headers["Authorization"]);
            if (user == null)
                return BadRequest("User doesn't exist");

            Order order = new Order()
            {
                Amount = totalPrice,
                UserId = user.Id,
                Products = products,
                Payed = 0
            };
            try
            {
                await _db.Orders.AddAsync(order);
                await _db.SaveChangesAsync();
            }
            catch
            {
                return BadRequest("Failed to make order, try again.");
            }

            if (await _braintreeService.TryMakePurchase(totalPrice, model.Nonce))
            {
                order.Payed = 1;
                _db.Orders.Update(order);
                await _db.SaveChangesAsync();

                return Ok($"Payment completed; {totalPrice} was deducted from your balance.");
            }
            else 
                return BadRequest($"an error has occured");
        }
    }
}
