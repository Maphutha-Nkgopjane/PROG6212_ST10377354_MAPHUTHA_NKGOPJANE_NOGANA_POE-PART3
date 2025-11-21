using cmcs2.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace cmcs2.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<WorkClaim> WorkClaims { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<EmployeeProfile> EmployeeProfiles { get; set; }
    }
}