using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.IO;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace Tools
{
    public class ToolsClass
    {
        private void CreateTempTable(string sFormTable, string sFormView)
        {
            String strConnString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            string sUser = (string)Session["UserName"];
            cmd.Parameters.Add("@UserId", SqlDbType.NVarChar).Value = sUser;
            cmd.CommandText = "delete from " + sFormTable + " where UserId = '" + sUser + "'"
                            + " insert into " + sFormTable
                            + " select Attribut, Operator, '', Datentyp, '" + sUser + "' from " + sFormView;
            cmd.Connection = con;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}
