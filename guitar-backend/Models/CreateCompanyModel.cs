using System.ComponentModel.DataAnnotations;

namespace guitar_backend.Models
{
    public class CreateCompanyModel
    {
        [Required]
        public string Name { get; set; } = string.Empty;
    }
}
