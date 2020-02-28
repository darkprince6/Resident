using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Resident.Services
{
    public class Registration
    {
        public int ComplexId { get; set; }
        public string UserName { get; set; }
        // public bool UserNameInUse { get; set; }
        public string UserNameInUse { get; set; }
    }
}