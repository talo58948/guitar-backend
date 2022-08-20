using System.ComponentModel.DataAnnotations;

namespace guitar_backend.ActionModels
{
    public class CreateCategoryModel
    {
        [Required]
        public string Name { get; set; } = null!;
    }
}
