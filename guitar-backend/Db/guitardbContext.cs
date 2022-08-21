using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace guitar_backend.Db
{
    public partial class guitardbContext : DbContext
    {
        private readonly IConfiguration _config;
        public guitardbContext(IConfiguration config)
        {
            _config = config;
        }

        public guitardbContext(DbContextOptions<guitardbContext> options, IConfiguration config)
            : base(options)
        {
            this._config = config;
        }

        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<Color> Colors { get; set; } = null!;
        public virtual DbSet<Company> Companies { get; set; } = null!;
        public virtual DbSet<Order> Orders { get; set; } = null!;
        public virtual DbSet<Password> Passwords { get; set; } = null!;
        public virtual DbSet<Product> Products { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql(_config["MySql:connectionString"], ServerVersion.Parse(_config["MySql:version"]));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.UseCollation("utf8mb3_general_ci")
                .HasCharSet("utf8mb3");

            modelBuilder.Entity<Category>(entity =>
            {
                entity.HasKey(e => e.Name)
                    .HasName("PRIMARY");

                entity.ToTable("categories");

                entity.HasIndex(e => e.Name, "name_UNIQUE")
                    .IsUnique();

                entity.Property(e => e.Name)
                    .HasMaxLength(64)
                    .HasColumnName("name")
                    .HasDefaultValueSql("''");
            });

            modelBuilder.Entity<Color>(entity =>
            {
                entity.HasKey(e => e.Name)
                    .HasName("PRIMARY");

                entity.ToTable("colors");

                entity.HasIndex(e => e.Name, "id_UNIQUE")
                    .IsUnique();

                entity.Property(e => e.Name)
                    .HasMaxLength(64)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<Company>(entity =>
            {
                entity.HasKey(e => e.Name)
                    .HasName("PRIMARY");

                entity.ToTable("companies");

                entity.HasIndex(e => e.Name, "name_UNIQUE")
                    .IsUnique();

                entity.Property(e => e.Name)
                    .HasMaxLength(64)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("orders");

                entity.HasIndex(e => e.Id, "id_UNIQUE")
                    .IsUnique();

                entity.HasIndex(e => e.UserId, "user_fk_idx");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Amount)
                    .HasPrecision(10, 2)
                    .HasColumnName("amount")
                    .HasDefaultValueSql("'0.00'");

                entity.Property(e => e.Payed)
                    .HasColumnName("payed")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("user_fk");
            });

            modelBuilder.Entity<Password>(entity =>
            {
                entity.ToTable("passwords");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Hash)
                    .HasColumnType("tinyblob")
                    .HasColumnName("hash");

                entity.Property(e => e.Salt)
                    .HasColumnType("tinyblob")
                    .HasColumnName("salt");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("products");

                entity.HasIndex(e => e.Category, "category_idx");

                entity.HasIndex(e => e.Color, "color_fk_idx");

                entity.HasIndex(e => e.Company, "company_fk_idx");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Category)
                    .HasMaxLength(64)
                    .HasColumnName("category")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.Color)
                    .HasMaxLength(64)
                    .HasColumnName("color")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.Company)
                    .HasMaxLength(64)
                    .HasColumnName("company")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasColumnName("createdAt")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Description)
                    .HasMaxLength(255)
                    .HasColumnName("description")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.ImageUrl)
                    .HasMaxLength(512)
                    .HasColumnName("imageUrl")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.Name)
                    .HasMaxLength(64)
                    .HasColumnName("name")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.Price)
                    .HasPrecision(10, 2)
                    .HasColumnName("price")
                    .HasDefaultValueSql("'0.00'");

                entity.Property(e => e.Quantity)
                    .HasColumnName("quantity")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.Shipping)
                    .HasColumnName("shipping")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.Sold)
                    .HasColumnName("sold")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.UpdatedAt)
                    .HasColumnType("datetime")
                    .HasColumnName("updatedAt")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.HasOne(d => d.CategoryNavigation)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.Category)
                    .HasConstraintName("category_fk");

                entity.HasOne(d => d.ColorNavigation)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.Color)
                    .HasConstraintName("color_fk");

                entity.HasOne(d => d.CompanyNavigation)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.Company)
                    .HasConstraintName("company_fk");

                entity.HasMany(d => d.Orders)
                    .WithMany(p => p.Products)
                    .UsingEntity<Dictionary<string, object>>(
                        "Productsorder",
                        l => l.HasOne<Order>().WithMany().HasForeignKey("Order").HasConstraintName("order-fk"),
                        r => r.HasOne<Product>().WithMany().HasForeignKey("Product").HasConstraintName("product-fk"),
                        j =>
                        {
                            j.HasKey("Product", "Order").HasName("PRIMARY").HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                            j.ToTable("productsorders");

                            j.HasIndex(new[] { "Order" }, "order-fk_idx");

                            j.IndexerProperty<int>("Product").HasColumnName("product");

                            j.IndexerProperty<int>("Order").HasColumnName("order");
                        });
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("users");

                entity.HasIndex(e => e.Name, "name_UNIQUE")
                    .IsUnique();

                entity.HasIndex(e => e.PasswordId, "password_idx");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasColumnName("createdAt")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Email)
                    .HasMaxLength(128)
                    .HasColumnName("email");

                entity.Property(e => e.Name)
                    .HasMaxLength(64)
                    .HasColumnName("name");

                entity.Property(e => e.PasswordId).HasColumnName("passwordId");

                entity.Property(e => e.Role)
                    .HasMaxLength(64)
                    .HasColumnName("role");

                entity.HasOne(d => d.Password)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.PasswordId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("password_fk");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
