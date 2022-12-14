using System.ComponentModel.DataAnnotations;

namespace guitar_backend.Models
{
    public class MakeOrderModel
    {
        [Required]
        public string Nonce { get; set; } = null!;
        public IEnumerable<int> ProductIds { get; set; } = new int[] { };
    }
}
