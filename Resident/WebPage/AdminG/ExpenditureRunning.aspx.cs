using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
    public partial class ExpenditureRunning : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        string _ip = string.Empty;
        string _user = string.Empty;
        string s = string.Empty;
        string _logo = "";
        string _image = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                s = Request.QueryString["Id"];
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                _user = User.Identity.Name;
                _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (_ip == "" || _ip == null)
                    _ip = Request.ServerVariables["REMOTE_ADDR"];
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = "ExpenditureRunning_Ins";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@CommitteeId", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@ActGroupId", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@Head", SqlDbType.NVarChar, 150).Value = txtHead.Text;
                cmd.Parameters.Add("@SubItem", SqlDbType.NVarChar, 150).Value = txtSubItem.Text;
                cmd.Parameters.Add("@PaymtIssuedBy", SqlDbType.NVarChar, 150).Value = txtPaymtIssuedBy.Text;
                cmd.Parameters.Add("@Amount", SqlDbType.Money).Value = txtAmount.Text;
                cmd.Parameters.Add("@ApprovalStatus", SqlDbType.Bit).Value = 1;
                cmd.Parameters.Add("@ApprovalDetails", SqlDbType.NVarChar, 150).Value = txtApprovalDetails.Text;
                cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void lbtnUpdate_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            LinkButton _lbtn = (LinkButton)sender;
            RepeaterItem _item = (RepeaterItem)_lbtn.Parent;
            HiddenField _hdnId = (HiddenField)_item.FindControl("hdnId");
            Label _lblHead = (Label)_item.FindControl("lblHead");
            Label _lblAmount = (Label)_item.FindControl("lblAmount");
            Label _lblSubItem = (Label)_item.FindControl("lblSubItem");
            Label _lblPaymtIssuedBy = (Label)_item.FindControl("lblPaymtIssuedBy");
            Label _lblApprovalDetails = (Label)_item.FindControl("lblApprovalDetails");

            hdnExpenditureId.Value = _hdnId.Value;
            txtHeadModal.Text = _lblHead.Text;
            txtAmountModal.Text = _lblAmount.Text;
            txtSubItemModal.Text = _lblSubItem.Text;
            txtPaymtIssuedByModal.Text = _lblPaymtIssuedBy.Text;
            txtApprovalDetailsModal.Text = _lblApprovalDetails.Text;

        }

        protected void btnSubmitModal_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = "ExpenditureRunning_Upd";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Head", SqlDbType.NVarChar, 150).Value = txtHeadModal.Text;
                cmd.Parameters.Add("@SubItem", SqlDbType.NVarChar, 150).Value = txtSubItemModal.Text;
                cmd.Parameters.Add("@PaymtIssuedBy", SqlDbType.NVarChar, 150).Value = txtPaymtIssuedByModal.Text;
                cmd.Parameters.Add("@Amount", SqlDbType.Money).Value = txtAmountModal.Text;
                cmd.Parameters.Add("@ApprovalDetails", SqlDbType.NVarChar, 150).Value = txtApprovalDetailsModal.Text;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIp", SqlDbType.NVarChar, 150).Value = _ip;

                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnExpenditureId.Value;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForExpenditure();", true);

                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModal();", true);
                RepExpenditureRunning.DataBind();
            }
        }
    }
}