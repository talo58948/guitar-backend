using System;
using System.Collections.Generic;

namespace guitar_backend.Db
{
    public partial class Order
    {
        public Order()
        {
            Products = new HashSet<Product>();
        }

        public int Id { get; set; }
        public decimal? Amount { get; set; }
        public int UserId { get; set; }
        public sbyte? Payed { get; set; }

        public virtual User User { get; set; } = null!;

        public virtual ICollection<Product> Products { get; set; }
    }
}
