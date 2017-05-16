using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace FilmsProject
{
    public partial class _Details : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = GetFilmId();
            
            if (!IsPostBack)
            {
                //In real project UserId is taken from database or other place
                Guid currentUser = Guid.Parse("059dcd13-d4b4-44ba-9937-6f6e6d0129d0");
                // Hide edit mode if user is not current
                using (var context = new FilmsEntities())
                {
                    //if current user then set edit mode
                    
                    Guid userId = context.Films
                        .Where(b => b.ID == id).Select(b => b.UserID)
                        .FirstOrDefault();

                    if (userId == currentUser)
                    {
                        SetEditMode(true);
                    }
                    else
                    {
                        SetEditMode(false);
                    }
                    
                }
                SetPosterImage(id);
                FilmDetailsView.AutoGenerateEditButton = false;
            }
            
            
        }

        protected void SetEditMode(bool isEdit)
        {
            if (isEdit)
                FilmDetailsView.ChangeMode(DetailsViewMode.Edit);
            else
                FilmDetailsView.ChangeMode(DetailsViewMode.ReadOnly);
            ((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtName")).ReadOnly = !isEdit;
            ((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtDescr")).ReadOnly = !isEdit;
            ((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtYear")).ReadOnly = !isEdit;
            ((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtDirector")).ReadOnly = !isEdit;
            SaveFilmBtn.Visible = isEdit; 
        }

        protected void SetPosterImage(int id)
        {
            //set image for poster
            using (var context = new FilmsEntities())
            {
                byte[] bytes = context.Films
                .Where(b => b.ID == id).Select(b => b.Poster)
                .FirstOrDefault();
                if (bytes!=null)
                {
                    if (bytes.Length != 0)
                    {
                        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);

                        Image imgPoster = (Image)FilmDetailsView.Rows[0].Cells[0].FindControl("imgPoster");
                        imgPoster.ImageUrl = "data:image/png;base64," + base64String;
                    }
                    
                }
            }
            
        }
      

        protected int GetFilmId()
        {
            return int.Parse(Request.QueryString["Id"]);
        }

        protected void SaveFilmBtn_Click(object sender, EventArgs e)
        {
            int id = GetFilmId();
            using (var context = new FilmsEntities())
            {
                var film = context.Films
                    .Where(b => b.ID == id)
                    .FirstOrDefault();

                film.Name = ((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtName")).Text.Trim();
                film.Description = ((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtDescr")).Text.Trim();
                string year=((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtYear")).Text.Trim();
                film.Year = short.Parse(year);
                film.Director = ((TextBox)FilmDetailsView.Rows[0].Cells[0].FindControl("txtDirector")).Text.Trim();

                FileUpload fileUpload = (FileUpload)FilmDetailsView.FindControl("PosterUpload");
                if (fileUpload != null)
                {
                    Stream fs = fileUpload.PostedFile.InputStream;
                    BinaryReader br = new BinaryReader(fs);
                    Byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    film.Poster = bytes;
                    
                }

                context.SaveChanges();
            }
            Response.Redirect("Default.aspx", false);
        }
        
        

        
    }
}