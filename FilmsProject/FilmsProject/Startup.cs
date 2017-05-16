using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FilmsProject.Startup))]
namespace FilmsProject
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
