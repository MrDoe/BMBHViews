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
                // Call Get ChartData() method in the PageLoad event
                GetChartData(chkShowValues.Checked);
                GetChartTypes();
            }
        }

        private void GetChartData(bool bShowLabels)
        {
            string cs = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Select [USERCOUNT], [TIMESTAMP] from CLIN106_DATA.dbo.USERCOUNT", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                // Retrieve the Series to which we want to add DataPoints
                Series series = Chart1.Series["Series1"];
                series.IsValueShownAsLabel = bShowLabels;
                series.ToolTip = "#VAL";

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
            GetChartData(chkShowValues.Checked);
            this.Chart1.Series["Series1"].ChartType = (SeriesChartType)Enum.Parse(
                typeof(SeriesChartType), DropDownList1.SelectedValue);
        }

        protected void chkShowValues_CheckedChanged(object sender, EventArgs e)
        {
            GetChartData(chkShowValues.Checked);
        }
    }
}
