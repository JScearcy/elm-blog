using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

namespace server.Migrations
{
    public partial class BlogPost : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Blogs",
                columns: table => new
                {
                    PostId = table.Column<int>(nullable: false)
                        .Annotation("Autoincrement", true),
                    ImgUrl = table.Column<string>(nullable: true),
                    LinkUrl = table.Column<string>(nullable: true),
                    PostBody = table.Column<string>(nullable: true),
                    PostTitle = table.Column<string>(maxLength: 140, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Blogs", x => x.PostId);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Blogs");
        }
    }
}
