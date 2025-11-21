using System.ComponentModel.DataAnnotations;

namespace cmcs2.Models
{
    public class AddEmployeeViewModel
    {

        public string? Name { get; set; }


        public string? Surname { get; set; }


        public string? Department { get; set; }


        public decimal DefaultRatePerJob { get; set; }


        public string? RoleName { get; set; }


        public string? Email { get; set; }


        public string? TempPassword { get; set; }
    }
}
