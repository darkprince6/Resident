using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using static Resident.MvcApplication;

namespace Resident
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapPageRoute("ResidentialComplexRoute",
                               "Complex",
                               "~/WebPage/Public/ResidentialComplex.aspx",
                               true, null,
                               new RouteValueDictionary { { "outgoing", new CustomConstaint() } }
                               );

            routes.MapPageRoute("ResidentialComplexDetailsRoute",
                              "Complex/{Name}/{Id}",
                              "~/WebPage/Public/ResidentialComplexDetails.aspx",
                              true, null,
                              new RouteValueDictionary { { "outgoing", new CustomConstaint() } }
                              );

            routes.MapPageRoute("AssoOBFeedRoute",
                              "Complex1/{ComplexName}/{Name}/{Id}",
                              "~/WebPage/Public/AssoOBFeed.aspx",
                              false, null,
                              new RouteValueDictionary { { "outgoing", new CustomConstaint() } }
                              );

            //routes.MapRoute(
            //    name: "Complex2",
            //    url: "",
            //    defaults: new { controller = "Complex", action = "Index" }
            //);

            //routes.MapRoute(
            //    name: "ResiComplex",
            //    url: "{Complex}/{Details}/{name}/{id}",
            //    defaults: new { controller = "Complex", action = "Details", name = UrlParameter.Optional, id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "Default2",
            //    url: "{controller}/{action}/{Country}/{State}",
            //    defaults: new { controller = "Complex", action = "Sample", Country = UrlParameter.Optional, State = UrlParameter.Optional }
            //);

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
