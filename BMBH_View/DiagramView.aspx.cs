using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.DataVisualization.Charting;

namespace BMBH_View
{
    public partial class DiagramView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtCalFrom.Text = DateTime.Now.AddDays(-14).ToString(calFrom.Format);
                txtCalTo.Text = DateTime.Now.ToString(calTo.Format);
                GetChartData(chkShowValues.Checked, txtCalFrom.Text, txtCalTo.Text);
                GetChartTypes();
            }
        }

        private void GetChartData(bool bShowLabels, string sFrom, string sTo)
        {
            string cs = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string sSQL = "Select [USERCOUNT], [TIMESTAMP] from CLIN106_DATA.dbo.USERCOUNT";

                if (sFrom.Length > 0 && sTo.Length > 0)
                    sSQL += " where [TIMESTAMP] between '" + sFrom + "' and '" + sTo + "'";
                
                SqlCommand cmd = new SqlCommand(sSQL, con);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                // Retrieve the Series to which we want to add DataPoints
                Series series = Chart1.Series["Series1"];
                series.IsValueShownAsLabel = bShowLabels;
                series.XValueType = ChartValueType.DateTime;
                series.ToolTip = "#Benutzer: #VALY\nZeitpunkt: #AXISLABEL";

                // Loop through each record
                while (rdr.Read())
                {
                    // Add X and Y values using AddXY() method
                    series.Points.AddXY(rdr["TIMESTAMP"].ToString(), rdr["USERCOUNT"]);
                }
            }
        }

        private void GetChartTypes()
        {
            foreach (int chartType in Enum.GetValues(typeof(SeriesChartType)))
            {
                ListItem li = new ListItem(Enum.GetName(typeof(SeriesChartType),
                    chartType), chartType.ToString());
                DropDownList1.Items.Add(li);
            }
            DropDownList1.SelectedIndex = 13;
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Call Get ChartData() method when the user select a different chart type
            GetChartData(chkShowValues.Checked, txtCalFrom.Text, txtCalTo.Text);
            this.Chart1.Series["Series1"].ChartType = (SeriesChartType)Enum.Parse(
                typeof(SeriesChartType), DropDownList1.SelectedValue);
        }

        protected void chkShowValues_CheckedChanged(object sender, EventArgs e)
        {
            GetChartData(chkShowValues.Checked, txtCalFrom.Text, txtCalTo.Text);
        }

        protected void txtCalFrom_TextChanged(object sender, EventArgs e)
        {
            GetChartData(chkShowValues.Checked, txtCalFrom.Text, txtCalTo.Text);
        }

        protected void txtCalTo_TextChanged(object sender, EventArgs e)
        {
            GetChartData(chkShowValues.Checked, txtCalFrom.Text, txtCalTo.Text);
        }
    }
}
