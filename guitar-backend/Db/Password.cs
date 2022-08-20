using System;
using System.Collections.Generic;

namespace guitar_backend.Db
{
    public partial class Password
    {
        public Password()
        {
            Users = new HashSet<User>();
        }

        public int Id { get; set; }
        public byte[] Hash { get; set; } = null!;
        public byte[] Salt { get; set; } = null!;

        public virtual ICollection<User> Users { get; set; }
    }
}
