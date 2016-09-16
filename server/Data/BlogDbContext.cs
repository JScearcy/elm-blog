using Microsoft.EntityFrameworkCore;
using WebApplication.Models;

namespace WebApplication.Data
{
    public class BlogDbContext : DbContext
    {
        public DbSet<Post> Posts { get; private set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite("Filename=./blog.db");
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Post>().ToTable("Blogs");
            modelBuilder.Entity<Post>().HasKey(k => k.PostId);
            modelBuilder.Entity<Post>().Property(k => k.PostTitle).HasMaxLength(140);
        }
    }
}