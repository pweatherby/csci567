using System;
using noble.coder.pweatherby.AppValet;

namespace noble.coder.pweatherby.AppValetWeb.Office
{
    public partial class RegisterApp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String UserName = CAS.Authenticate(this, false);
            if (!UserName.Equals("pweatherby", StringComparison.InvariantCultureIgnoreCase))
            {
                throw new UnauthorizedAccessException("Only Paul Weatherby can Register Apps");
            }
        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            String newID = Guid.NewGuid().ToString("D");
            ValetOffice.UpdateApp(newID, AppNameTextbox.Text);
        }
    }
}