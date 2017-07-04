using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using OfficeOpenXml;

namespace BMBH_View
{
    public partial class PancoBank_Liquid : System.Web.UI.Page
    {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    dgdNCT.AllowPaging = true;
                    dgdNCT.DataSource = GetData();
                    dgdNCT.DataBind();
                }

                txtMaxPage.Text = dgdNCT.PageCount.ToString();
            }

            private void ShowMsg(string message)
            {
                Response.Write("<script>alert('" + message + "');</script>");
            }

            public DataTable GetData()
            {
                string sSQL;

                if (Session["LastQuery"] == null)
                    sSQL = "SELECT * FROM V_PANCOBANK_LIQUID order by InventarID";
                else
                    sSQL = Session["LastQuery"].ToString();

                using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString))
                using (var cmd = new SqlCommand(sSQL, conn))
                using (var adapter = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    adapter.Fill(dt);
                    txtTotalRows.Text = dt.Rows.Count.ToString();
                    return dt;
                }
            }

            protected void btnExcel_Click(object sender, EventArgs e)
            {
                var datatable = GetData();
                ExcelPackage excel = new ExcelPackage();
                var workSheet = excel.Workbook.Worksheets.Add("Pancobank_Liquid");
                var totalCols = datatable.Columns.Count;
                var totalRows = datatable.Rows.Count;

                for (var col = 1; col <= totalCols; col++)
                    workSheet.Cells[1, col].Value = datatable.Columns[col - 1].ColumnName;

                for (var row = 1; row <= totalRows; row++)
                    for (var col = 0; col < totalCols; col++)
                        workSheet.Cells[row + 1, col + 1].Value = datatable.Rows[row - 1][col];

                using (var memoryStream = new MemoryStream())
                {
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;  filename=export.xlsx");
                    excel.SaveAs(memoryStream);
                    memoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            dgdNCT.PageIndex = Int32.Parse(txtPage.Text) - 1;
            dgdNCT.PageSize = Int32.Parse(txtRowPerPage.Text);
            dgdNCT.DataSource = GetData();
            dgdNCT.DataBind();
            txtMaxPage.Text = dgdNCT.PageCount.ToString();
        }

        protected void btnPrevPage_Click(object sender, ImageClickEventArgs e)
        {
            int nPageNo = Int32.Parse(txtPage.Text) - 1;
            txtPage.Text = nPageNo.ToString();
            dgdNCT.PageIndex = nPageNo - 1;
            dgdNCT.DataSource = GetData();
            dgdNCT.DataBind();
        }

        protected void btnNextPage_Click(object sender, ImageClickEventArgs e)
        {
            int nPageNo = Int32.Parse(txtPage.Text) + 1;
            txtPage.Text = nPageNo.ToString();
            dgdNCT.PageIndex = nPageNo - 1;
            dgdNCT.DataSource = GetData();
            dgdNCT.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //            if (Session["LastQuery"] != null)
            //                ShowMsg(Session["LastQuery"].ToString());
        }
    }
}