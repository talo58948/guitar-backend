using guitar_backend.ActionModels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace guitar_backend.Controllers
{
    /// <summary>
    /// Defines <c>Product</c>s routes, that are used for fetching the <c>Product</c>s in app.
    /// </summary>
    [Route("[controller]")]
    public class ProductsController : Controller
    {
        /// <summary>
        /// The <c>DbContext</c> used by the actions to fetch <c>Product</c>s from the database.
        /// </summary>
        private readonly guitardbContext _db;

        /// <summary>
        /// The controller constructor, used by DI.
        /// </summary>
        /// <param name="db">The <c>DbContext</c> used by the actions to fetch <c>Product</c>s from the database.</param>
        public ProductsController(guitardbContext db)
        {
            this._db = db;
        }
        /// <summary>
        /// Gets all <c>Product</c>s from the database.
        /// </summary>
        /// <returns><c>Ok</c> with all the <c>Product</c>s.</returns>
        [HttpGet()]
        public async Task<IActionResult> GetAllProducts()
        {
            var products = await _db.Products.ToListAsync();
            return Ok(products);
        }
        /// <summary>
        /// Gets all <c>Product</c>s from the database of a given <c>Category</c>.
        /// </summary>
        /// <param name="category">The <c>Category</c> to filter by.</param>
        /// <returns><c>Ok</c> with the <c>Product</c>s of a given <c>Category</c>.</returns>
        [HttpGet("[action]{category=string}")]
        public async Task<IActionResult> GetProductsByCategory(string category)
        {
            var products = await _db.Products.Where(p => p.Category == category).ToListAsync();
            return Ok(products);
        }
        /// <summary>
        /// Gets <c>Product</c> by a given Id.
        /// </summary>
        /// <param name="id">The Id of the wanted <c>Product</c>.</param>
        /// <returns><c>Ok</c> with the wanted <c>Product</c></returns>
        [HttpGet("[action]{id=int}")]
        public async Task<IActionResult> GetProductById(int id)
        {
            var product = await _db.Products.SingleOrDefaultAsync(p => p.Id == id);
            return Ok(product);
        }
        /// <summary>
        /// Gets all the <c>Product</c>s that match the search parameters.
        /// </summary>
        /// <param name="model">A model containing all the identifiers of the wanted <c>Product</c>s.</param>
        /// <param name="limit">The maximum amount of <c>Product</c>s to be returned.</param>
        /// <param name="step">The offset of the matching <c>Product</c>s.</param>
        /// <param name="sortBy">The <c>Product</c>'s property name to sort by.</param>
        /// <param name="desc">If true, orders outputs in descending order, otherwise in ascending order.</param>
        /// <returns>All of the <c>Product</c>s that match the profile specified in the body of the request.</returns>
        [HttpPost("[action]")]
        public async Task<IActionResult> Search([FromBody] SearchModel model, int limit, int step, string sortBy = "CreatedAt", bool desc = true)
        {
            var productsQuery = _db.Products.Where(p =>
                    p.Name != null ? p.Name.ToLower().Contains(model.SearchStr.ToLower()) : true &&
                    model.Color != null ? p.Color == model.Color : true &&
                    model.Company != null ? p.Company == model.Company : true &&
                    model.Category != null ? p.Category == model.Category : true
                );
            int count = await productsQuery.CountAsync();
            var products = await productsQuery.OrderBy(sortBy, desc).Skip(step).Take(limit).ToListAsync();
            return Ok(new SearchResultModel() { Found = count, Products = products});
        }
    }
}
