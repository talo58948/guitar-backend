using System;
using System.Collections.Generic;

namespace guitar_backend.Db
{
    public partial class User
    {
        public User()
        {
            Orders = new HashSet<Order>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public int PasswordId { get; set; }
        public string? Email { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string? Role { get; set; }

        public virtual Password Password { get; set; } = null!;
        public virtual ICollection<Order> Orders { get; set; }
    }
}
