using Resident.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Resident.Controllers
{
    public class ComplexController : Controller
    {
        // GET: Complex
        private Residence4UmDBContext db = new Residence4UmDBContext();
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetComplex(string prefix)
        {

            var ComplexList = (from c in db.ResidentialComplexes
                               where c.Name.StartsWith(prefix)
                               select new
                               {
                                   label = c.Name,
                                   val = c.Id
                               }).ToList();
            return Json(ComplexList, JsonRequestBehavior.AllowGet);

        }

        [HttpPost]
        public ActionResult Index(string name, string id)
        {
            if (!string.IsNullOrEmpty(name))
            {

                ViewBag.Message = ("Name:- " + name + "---- Id:- " + id);
            }
            else
            {
                ViewBag.Message = ("No Data Found");
            }
            return View();
        }

       // [Route("Complex/{id:int}")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ResidentialComplex residentialComplex = db.ResidentialComplexes.FirstOrDefault(x=>x.Id==id);

            
            if (residentialComplex == null)
            {
                return HttpNotFound();
            }
            return View(residentialComplex);
        }
        
        public ActionResult AllDetails()
        {
            return View(db.ResidentialComplexes.ToList());
        }

        public ActionResult Sample(string country, string state)
        {
            ViewBag.Message = ("Country:- " + country + " ==== State:- " + state);
            return View();
        }
    }


}