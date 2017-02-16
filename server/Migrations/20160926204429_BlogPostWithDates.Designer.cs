using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using WebApplication.Data;

namespace server.Migrations
{
    [DbContext(typeof(BlogDbContext))]
    [Migration("20160926204429_BlogPostWithDates")]
    partial class BlogPostWithDates
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
            modelBuilder
                .HasAnnotation("ProductVersion", "1.0.0-rtm-21431");

            modelBuilder.Entity("WebApplication.Models.Post", b =>
                {
                    b.Property<int>("PostId")
                        .ValueGeneratedOnAdd();

                    b.Property<DateTime?>("EditDate");

                    b.Property<string>("ImgUrl");

                    b.Property<string>("LinkUrl");

                    b.Property<string>("PostBody");

                    b.Property<string>("PostTitle")
                        .HasAnnotation("MaxLength", 140);

                    b.HasKey("PostId");

                    b.ToTable("Blogs");
                });
        }
    }
}
