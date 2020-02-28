namespace Resident.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ResidentsAssociation")]
    public partial class ResidentsAssociation
    {
        public int Id { get; set; }

        public int ResComId { get; set; }

        [Required]
        [StringLength(250)]
        public string Name { get; set; }

        [StringLength(250)]
        public string NameAlt { get; set; }

        [StringLength(20)]
        public string Abbr { get; set; }

        public DateTime? StartDt { get; set; }

        public int? StartYr { get; set; }

        public string Logo { get; set; }

        public string Image1 { get; set; }

        public string Video1 { get; set; }

        [StringLength(500)]
        public string Descr { get; set; }

        public int? Priority { get; set; }

        public bool IsApproved { get; set; }

        public bool IsActive { get; set; }

        public bool? IsDel { get; set; }

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

        [ForeignKey("ResComId")]
        public virtual ResidentialComplex ResidentialComplex { get; set; }

    }
}
