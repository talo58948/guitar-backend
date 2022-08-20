using System;
using System.Collections.Generic;

namespace guitar_backend.Db
{
    public partial class Color
    {
        public Color()
        {
            Products = new HashSet<Product>();
        }

        public string Name { get; set; } = null!;

        public virtual ICollection<Product> Products { get; set; }
    }
}
