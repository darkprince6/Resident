namespace Resident.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ResComPO")]
    public partial class ResComPO
    {
        public int Id { get; set; }

        public int ResComId { get; set; }

        public int POId { get; set; }

        [StringLength(250)]
        public string PostOffice { get; set; }

        [StringLength(250)]
        public string Address1 { get; set; }

        [StringLength(250)]
        public string Address2 { get; set; }

        [StringLength(50)]
        public string PinCode { get; set; }

        [StringLength(100)]
        public string Email { get; set; }

        [StringLength(150)]
        public string Website { get; set; }

        [StringLength(50)]
        public string Phone1 { get; set; }

        [StringLength(50)]
        public string Phone2 { get; set; }

        public string Image1 { get; set; }

        public string Image2 { get; set; }

        public string Video1 { get; set; }

        public string Video2 { get; set; }

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

        [ForeignKey("ResComId")]
        public virtual ResidentialComplex ResidentialComplex { get; set; }
    }
}
