using System.ComponentModel.DataAnnotations;

namespace cmcs2.Models
{
    public class Notification
    {
        public int Id { get; set; }

        [Required]
        [StringLength(200)]
        public required string Message { get; set; }

        [Required]
        [StringLength(50)]
        public required string TargetRole { get; set; }

        public bool IsRead { get; set; } = false;

        public int? WorkClaimId { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}