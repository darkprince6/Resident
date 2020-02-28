USE [Residence4UmDB]
GO

/****** Object:  StoredProcedure [dbo].[Help_Ins]    Script Date: 18-Nov-19 11:32:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Help_Ins]

@ComplexId INT, 
@Title NVARCHAR(100), 
@Descr NVARCHAR(500), 
@CrBy NVARCHAR(50),
@CrByIP NVARCHAR(50),
@CrDt DATETIME


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO 
			Help 
				(ComplexId, Title, Descr, CrBy, CrDt, CrByIP) 
			VALUES
				(@ComplexId, @Title, @Descr, @CrBy, @CrDt, @CrByIP)
END
GO

/****** Object:  StoredProcedure [dbo].[Help_Remove]    Script Date: 18-Nov-19 11:32:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Help_Remove]

@Id INT, 
@ModBy NVARCHAR(200),
@ModByIP NVARCHAR(100),
@ModDt DATETIME


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE
		  Help
		SET
		  IsDel=1,
		  ModBy = @ModBy,
		  ModDt = @ModDt,
		  ModDtSys=GETDATE(),
		  ModByIP = @ModByIP
		WHERE
		  Id = @Id
			
END
GO

/****** Object:  StoredProcedure [dbo].[Help_Sel_List]    Script Date: 18-Nov-19 11:32:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Help_Sel_List]

@ComplexId INT
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SELECT
 Id,
 Title,
 Descr,
 IsDel,
 CrDt,
 ModDt
FROM
 Help
WHERE
 ComplexId = @ComplexId
END
GO

/****** Object:  StoredProcedure [dbo].[Help_Upd]    Script Date: 18-Nov-19 11:32:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Help_Upd]

@Id INT, 
@Title NVARCHAR(100), 
@Descr NVARCHAR(500), 
@ModBy NVARCHAR(200),
@ModByIP NVARCHAR(100),
@ModDt DATETIME


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE
		  Help
		SET
		  Title=@Title,
		  Descr=@Descr,
		  ModBy = @ModBy,
		  ModDt = @ModDt,
		  ModDtSys=GETDATE(),
		  ModByIP = @ModByIP
		WHERE
		  Id = @Id
			
END
GO

/****** Object:  StoredProcedure [dbo].[HelpReply_Ins]    Script Date: 18-Nov-19 11:32:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[HelpReply_Ins]

@HelpId INT, 
@Descr NVARCHAR(500), 
@CrBy NVARCHAR(50),
@CrByIP NVARCHAR(50),
@CrDt DATETIME


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO 
			HelpReply 
				(HelpId, Descr, CrBy, CrDt, CrByIP) 
			VALUES
				(@HelpId, @Descr, @CrBy, @CrDt, @CrByIP)
END
GO

/****** Object:  StoredProcedure [dbo].[HelpReply_Sel_List]    Script Date: 18-Nov-19 11:32:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[HelpReply_Sel_List]

@HelpId INT
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SELECT
 Id,
 Descr,
 IsDel,
 CrDt,
 ModDt
FROM
 HelpReply
WHERE
 HelpId = @HelpId
END
GO

