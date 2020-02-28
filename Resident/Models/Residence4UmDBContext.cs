namespace Resident.Controllers
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using Resident.Models;

    public partial class Residence4UmDBContext : DbContext
    {
        public Residence4UmDBContext()
            : base("name=Residence4UmDBContext")
        {
            //Disable initializer
            Database.SetInitializer<Residence4UmDBContext>(null);
        }
        public virtual DbSet<ResComCat> ResComCats { get; set; }
        public virtual DbSet<ResidentialComplex> ResidentialComplexes { get; set; }
        public virtual DbSet<ResidentsAssociation> ResidentsAssociations { get; set; }
        public virtual DbSet<ResComPO> ResComPOes { get; set; }
        public virtual DbSet<ResComP> ResComPS { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
        }
    }
}
