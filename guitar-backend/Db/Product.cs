using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace guitar_backend.Db
{
    public partial class Product
    {
        public Product()
        {
            Orders = new HashSet<Order>();
        }

        public int Id { get; set; }
        public int? Sold { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public int? Quantity { get; set; }
        public sbyte? Shipping { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? Category { get; set; }
        public string? ImageUrl { get; set; }
        public string? Company { get; set; }
        public string? Color { get; set; }
        public decimal? Price { get; set; }

        [JsonIgnore]
        public virtual Category? CategoryNavigation { get; set; }
        [JsonIgnore]
        public virtual Color? ColorNavigation { get; set; }
        [JsonIgnore]
        public virtual Company? CompanyNavigation { get; set; }

        [JsonIgnore]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
