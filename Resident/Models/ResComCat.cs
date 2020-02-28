namespace Resident.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ResComCat")]
    public partial class ResComCat
    {
        public int Id { get; set; }

        public int CountryId { get; set; }

        [Required]
        [StringLength(100)]
        public string Cat { get; set; }

        [StringLength(500)]
        public string Descr { get; set; }

        public short Priority { get; set; }

        public bool IsDel { get; set; }

        public bool? IsAppr { get; set; }

        public bool? IsActive { get; set; }

        public DateTime? CrDt { get; set; }

        public DateTime? CrDtSys { get; set; }

        [StringLength(50)]
        public string CrBY { get; set; }

        [StringLength(50)]
        public string CrByIP { get; set; }

        public bool IsMod { get; set; }

        public int? ModCount { get; set; }

        public DateTime? ModDt { get; set; }

        public DateTime? ModDtSys { get; set; }

        [StringLength(50)]
        public string ModBy { get; set; }

        [StringLength(50)]
        public string ModByIP { get; set; }

        [StringLength(250)]
        public string Roles { get; set; }

        public string ModDescr { get; set; }

        public ICollection<ResidentialComplex> ResidentialComplexs { get; set; }
    }
}
