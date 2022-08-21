using guitar_backend.ActionModels;
using Microsoft.AspNetCore.Mvc;

namespace guitar_backend.Controllers
{
    /// <summary>
    /// Defines Admin specific routes, which require the Admin role for access.
    /// </summary>
    [Route("[controller]")]
    [Authorize(Roles ="admin")]
    public class AdminController : Controller
    {
        /// <summary>
        /// The <c>DbContext</c> used to query data in the actions.
        /// </summary>
        private readonly guitardbContext _db;
        /// <summary>
        /// Controller constructor used for DI.
        /// </summary>
        /// <param name="db">The <c>DbContext</c> used to query data in the actions.</param>
        public AdminController(guitardbContext db)
        {
            _db = db;
        }
        /// <summary>
        /// Creates a new <c>Product</c> and adds it to the database.
        /// </summary>
        /// <param name="productModel">The <c>Product</c> model, used to create a new <c>Product</c>.</param>
        /// <returns><c>Ok</c> if <c>Product</c> has been added to the database succesfully, otherwise <c>BadRequest</c>.</returns>
        [HttpPost("[action]")]
        public async Task<IActionResult> CreateProduct([FromBody] CreateProductModel productModel)
        {
            List<string> errors = new List<string>();
            if (productModel.Category != null && !await _db.Categories.AnyAsync(c => c.Name.ToLower() == productModel.Category.ToLower()))
                errors.Add($"Category `{productModel.Category}` does'nt exist");
            if (productModel.Color != null && !await _db.Colors.AnyAsync(c => c.Name.ToLower() == productModel.Color.ToLower()))
                errors.Add($"Color `{productModel.Color}` does'nt exist");
            if (productModel.Company != null && !await _db.Companies.AnyAsync(c => c.Name.ToLower() == productModel.Company.ToLower()))
                errors.Add($"Company `{productModel.Company}` does'nt exist");
            if (errors.Count > 0)
                return BadRequest(string.Join("\n", errors));

            Product newProduct = new Product()
            {
                Id = productModel.Id ?? 0,
                Name = productModel.Name,
                Description = productModel.Description,
                Quantity = productModel.Quantity,
                Shipping = (productModel.Shipping ?? false) ? (sbyte)1 : (sbyte)0,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow,
                Category = productModel.Category,
                Color = productModel.Color,
                Company = productModel.Company
            };
            await _db.Products.AddAsync(newProduct);
            await _db.SaveChangesAsync();
            return Ok("Product succesfully added");
        }
        /// <summary>
        /// Updates a <c>Product</c> by it's id.
        /// </summary>
        /// <param name="productModel">The <c>Product</c> model, used to update a <c>Product</c>.</param>
        /// <param name="id">The id used to find the <c>Product</c>.</param>
        /// <returns><c>Ok</c> if product was found and updated, otherwise <c>BadRequest</c>.</returns>
        [HttpPost("[action]")]
        public async Task<IActionResult> UpdateProductById([FromBody] CreateProductModel productModel, int id)
        {
            Product product;
            try
            {
                product = await _db.Products.FirstAsync(p => p.Id == id);
            }
            catch
            {
                return BadRequest("Product id doesn't exist");
            }
            product.Shipping = (productModel.Shipping ?? false) ? (sbyte)1 : (sbyte)0;
            product.Description = productModel.Description ?? product.Description;
            product.Quantity = productModel.Quantity ?? product.Quantity;
            product.Name = productModel.Name ?? product.Name;
            product.Category = productModel.Category ?? product.Category;
            product.ImageUrl = productModel.ImageUrl ?? product.ImageUrl;
            product.Company = productModel.Company ?? product.Company;
            product.Color = productModel.Color ?? product.Color;
            _db.Products.Update(product);
            await _db.SaveChangesAsync();
            return Ok("Product has been updated");
        }
        /// <summary>
        /// Creates a new <c>Category</c> and adds it to the database.
        /// </summary>
        /// <param name="categoryModel">The <c>Category</c> model, used to create a new <c>Category</c>.</param>
        /// <returns><c>Ok</c> if <c>Category</c> has been added to the database succesfully, otherwise <c>BadRequest</c>.</returns>
        [HttpPost("[action]")]
        public async Task<IActionResult> CreateCategory([FromBody] CreateCategoryModel categoryModel)
        {
            if (await _db.Categories.AnyAsync(c => c.Name.ToLower() == categoryModel.Name.ToLower()))
                return BadRequest($"Category with this name already exists. Category name: {categoryModel.Name}");
            await _db.Categories.AddAsync(new Category() { Name = categoryModel.Name });
            await _db.SaveChangesAsync();
            return Ok("Category succesfully added");
        }
        /// <summary>
        /// Creates a new <c>Color</c> and adds it to the database.
        /// </summary>
        /// <param name="colorModel">The <c>Color</c> model, used to create a new <c>Color</c>.</param>
        /// <returns><c>Ok</c> if <c>Color</c> has been added to the database succesfully, otherwise <c>BadRequest</c>.</returns>
        [HttpPost("[action]")]
        public async Task<IActionResult> CreateColor([FromBody] CreateColorModel colorModel)
        {
            if (await _db.Colors.AnyAsync(c => c.Name.ToLower() == colorModel.Name.ToLower()))
                return BadRequest($"Color with this name already exists. Color name: {colorModel.Name}");
            await _db.Colors.AddAsync(new Color() { Name = colorModel.Name });
            await _db.SaveChangesAsync();
            return Ok("Color succesfully added");
        }
        /// <summary>
        /// Creates a new <c>Company</c> and adds it to the database.
        /// </summary>
        /// <param name="companyModel">The <c>Company</c> model, used to create a new <c>Company</c>.</param>
        /// <returns><c>Ok</c> if <c>Company</c> has been added to the database succesfully, otherwise <c>BadRequest</c>.</returns>
        [HttpPost("[action]")]
        public async Task<IActionResult> CreateCompany([FromBody] CreateCategoryModel companyModel)
        {
            if (await _db.Companies.AnyAsync(c => c.Name.ToLower() == companyModel.Name.ToLower()))
                return BadRequest($"Company with this name already exists. Company name: {companyModel.Name}");
            await _db.Companies.AddAsync(new Company() { Name = companyModel.Name });
            await _db.SaveChangesAsync();
            return Ok("Company succesfully added");
        }
        /// <summary>
        /// Gets all the <c>Order</c>s that have been made in app.
        /// </summary>
        /// <returns>All the <c>Order</c>s that have been made in app.</returns>
        [HttpGet("[action]")]
        public async Task<IActionResult> GetAllOrders()
        {
            return Ok(await _db.Orders.Include(o => o.User).Include(o => o.Products).ToListAsync());
        }
    }
}
