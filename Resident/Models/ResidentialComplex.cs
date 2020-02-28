namespace Resident.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ResidentialComplex")]
    public partial class ResidentialComplex
    {
        public int Id { get; set; }

        //[Required]
        //[StringLength(250)]
        public string Name { get; set; }

        [StringLength(250)]
        public string NameAlt { get; set; }

        [StringLength(50)]
        public string Abbr { get; set; }

        public int ResComCatId { get; set; }

        public int ParentId { get; set; }

        public int? DistrictId { get; set; }

        public int? StateId { get; set; }

        public int CountryId { get; set; }

        public DateTime? Founded { get; set; }

        public int? FoundedYr { get; set; }

        [StringLength(50)]
        public string YearOrSem { get; set; }

        [StringLength(500)]
        public string Descr { get; set; }

        public string Logo { get; set; }

        public string CoverImg { get; set; }

        public string Video1 { get; set; }

        public int Priority { get; set; }

        public bool IsDel { get; set; }

        public bool IsApproved { get; set; }

        public bool IsActive { get; set; }

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

        [ForeignKey("ResComCatId")]
        public virtual ResComCat ResComCat { get; set; }

        public ICollection<ResidentsAssociation> ResidentsAssociations { get; set; }

        public ICollection<ResComP> ResComPs { get; set; }

        public ICollection<ResComPO> ResComPOes { get; set; }


    }
}
