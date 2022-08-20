using System.ComponentModel.DataAnnotations;

namespace guitar_backend.ActionModels
{
    public class CreateProductModel
    {
        public int? Id { get; set; }
        [Required]
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; }
        public int? Quantity { get; set; }
        public bool? Shipping { get; set; }
        public string? Category { get; set; }
        public string? ImageUrl { get; set; }
        public string? Color { get; set; }
        public string? Company { get; set; }
    }
}
