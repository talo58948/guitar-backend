using System.ComponentModel.DataAnnotations;

namespace guitar_backend.Models
{
    public class CreateColorModel
    {
        [Required]
        public string Name { get; set; } = string.Empty;
    }
}
