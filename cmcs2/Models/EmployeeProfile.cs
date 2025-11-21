using System.ComponentModel.DataAnnotations;

namespace cmcs2.Models
{
    public class EmployeeProfile
    {
        public int Id { get; set; }

        [Required]
        public required string UserId { get; set; }

        [Required]
        [StringLength(50)]
        public required string Name { get; set; }

        [Required]
        [StringLength(50)]
        public required string Surname { get; set; }

        [Required]
        [StringLength(50)]
        public required string Department { get; set; }

        [Required]
        [Range(0, 999999)]
        public decimal DefaultRatePerJob { get; set; }

        [Required]
        [StringLength(50)]
        public required string RoleName { get; set; }
    }
}