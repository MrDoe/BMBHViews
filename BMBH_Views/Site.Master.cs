using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.DirectoryServices;
using System.Linq;
using System.Net.Mail;
using System.Web.UI;

namespace BMBHviews
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] != null)
            {
                lblUserName.Text = (string)Session["UserName"];
            }
            else
            {
                Session["UserName"] = Context.User.Identity.Name.ToString();
                lblUserName.Text = (string)Session["UserName"];
            }

            if (Session["IsAdmin"] != null && (bool)Session["IsAdmin"] == true)
            {
                lnkUserMan.Visible = true;
            }
            else
            {
                lnkUserMan.Visible = false;
            }
        }

        protected void AsyncError(object sender, AsyncPostBackErrorEventArgs e)
        {
            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            ScriptManager.GetCurrent(Page).AsyncPostBackErrorMessage =
                "Fehler: " +
                e.Exception.Message;
        }

        public static string[][] GetSysConfig()
        {
            DataSet ds = new DataSet("SysConfig");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("select * from SysConfig where OPTION_NAME like 'EMAIL_%'", con)
                {
                    CommandType = CommandType.Text
                };
                SqlDataAdapter da = new SqlDataAdapter
                {
                    SelectCommand = cmd
                };
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return StringArray3(ds);
                }
                else
                {
                    return null;
                }
            }
        }

        // convert dataset to 2D string array
        private static string[][] StringArray3(DataSet ds)
        {
            int nRows = ds.Tables[0].Rows.Count;
            string[][] stringArray = new string[nRows][];

            for (int row = 0; row < nRows; ++row)
            {
                stringArray[row] = new string[3]
                                   { ds.Tables[0].Rows[row][0].ToString(),
                                     ds.Tables[0].Rows[row][1].ToString(),
                                     ds.Tables[0].Rows[row][2].ToString() };
            }

            return stringArray;
        }

        // sends email message to user
        public static void SendEmail(string sReceipient, string sMessage, string sSubject)
        {
            string[][] aResult = GetSysConfig();
            SmtpClient smtpClient = new SmtpClient(aResult[0][2], Convert.ToInt16(aResult[1][2]))
            {
                Credentials = new System.Net.NetworkCredential(aResult[2][2], aResult[3][2]), // username, passwd
                UseDefaultCredentials = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                EnableSsl = false
            }; // address, port
            MailMessage mail = new MailMessage
            {
                Subject = sSubject,
                From = new MailAddress(aResult[5][2], aResult[4][2]) // sender address, name
            };
            mail.To.Add(new MailAddress(sReceipient)); // receiver address
            mail.Body = sMessage;

            smtpClient.Send(mail);
        }

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        public string GetEmailFromUser(string sUsername)
        {
            if (sUsername == null)
            {
                throw new ArgumentNullException(nameof(sUsername));
            }

            if (sUsername.Contains('\\'))
            {
                sUsername = sUsername.Split('\\')[1];
            }

            string email = "";
            // get a DirectorySearcher object
            DirectoryEntry entry = new DirectoryEntry();
            DirectorySearcher search = new DirectorySearcher(entry)
            {

                // specify the search filter
                Filter = "(&(objectClass=user)(anr=" + sUsername + "))"
            };
            search.PropertiesToLoad.Add("mail"); // smtp mail address

            SearchResult result = search.FindOne();
            if (result == null)
            {
                ShowMsg("user " + sUsername + " not found");
            }
            else
            {
                email = (string)result.Properties["mail"][0];
            }

            return email;
        }

    }
}
