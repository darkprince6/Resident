USE [Residence4UmDB]
GO

/****** Object:  Table [dbo].[BuySell]    Script Date: 18-Nov-19 11:32:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BuySell](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplexId] [int] NULL,
	[Title] [nvarchar](150) NULL,
	[Descr] [nvarchar](500) NULL,
	[Price] [money] NULL,
	[Image] [nvarchar](max) NULL,
	[Priority] [smallint] NOT NULL,
	[IsDel] [bit] NULL,
	[IsAppr] [bit] NULL,
	[IsActive] [bit] NULL,
	[CrDt] [datetime] NULL,
	[CrDtSys] [datetime] NULL,
	[CrBy] [nvarchar](50) NULL,
	[CrByIP] [nvarchar](50) NULL,
	[IsMod] [bit] NOT NULL,
	[ModCount] [int] NULL,
	[ModDt] [datetime] NULL,
	[ModDtSys] [datetime] NULL,
	[ModBy] [nvarchar](50) NULL,
	[ModByIP] [nvarchar](50) NULL,
	[Roles] [nvarchar](250) NULL,
	[ModDescr] [nvarchar](max) NULL,
 CONSTRAINT [PK_BuySell] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BuySellReply]    Script Date: 18-Nov-19 11:32:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BuySellReply](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BuySellId] [int] NULL,
	[Title] [nvarchar](150) NULL,
	[Descr] [nvarchar](500) NULL,
	[Priority] [smallint] NOT NULL,
	[IsDel] [bit] NULL,
	[IsAppr] [bit] NULL,
	[IsActive] [bit] NULL,
	[CrDt] [datetime] NULL,
	[CrDtSys] [datetime] NULL,
	[CrBy] [nvarchar](50) NULL,
	[CrByIP] [nvarchar](50) NULL,
	[IsMod] [bit] NOT NULL,
	[ModCount] [int] NULL,
	[ModDt] [datetime] NULL,
	[ModDtSys] [datetime] NULL,
	[ModBy] [nvarchar](50) NULL,
	[ModByIP] [nvarchar](50) NULL,
	[Roles] [nvarchar](250) NULL,
	[ModDescr] [nvarchar](max) NULL,
 CONSTRAINT [PK_BuySellReply] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Help]    Script Date: 18-Nov-19 11:32:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Help](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplexId] [int] NULL,
	[Title] [nvarchar](150) NULL,
	[Descr] [nvarchar](500) NULL,
	[Priority] [smallint] NOT NULL,
	[IsDel] [bit] NULL,
	[IsAppr] [bit] NULL,
	[IsActive] [bit] NULL,
	[CrDt] [datetime] NULL,
	[CrDtSys] [datetime] NULL,
	[CrBy] [nvarchar](50) NULL,
	[CrByIP] [nvarchar](50) NULL,
	[IsMod] [bit] NOT NULL,
	[ModCount] [int] NULL,
	[ModDt] [datetime] NULL,
	[ModDtSys] [datetime] NULL,
	[ModBy] [nvarchar](50) NULL,
	[ModByIP] [nvarchar](50) NULL,
	[Roles] [nvarchar](250) NULL,
	[ModDescr] [nvarchar](max) NULL,
 CONSTRAINT [PK_Help] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HelpReply]    Script Date: 18-Nov-19 11:32:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HelpReply](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HelpId] [int] NULL,
	[Descr] [nvarchar](500) NULL,
	[Priority] [smallint] NOT NULL,
	[IsDel] [bit] NULL,
	[IsAppr] [bit] NULL,
	[IsActive] [bit] NULL,
	[CrDt] [datetime] NULL,
	[CrDtSys] [datetime] NULL,
	[CrBY] [nvarchar](50) NULL,
	[CrByIP] [nvarchar](50) NULL,
	[IsMod] [bit] NOT NULL,
	[ModCount] [int] NULL,
	[ModDt] [datetime] NULL,
	[ModDtSys] [datetime] NULL,
	[ModBy] [nvarchar](50) NULL,
	[ModByIP] [nvarchar](50) NULL,
	[Roles] [nvarchar](250) NULL,
	[ModDescr] [nvarchar](max) NULL,
 CONSTRAINT [PK_HelpReply] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_Priority]  DEFAULT ((0)) FOR [Priority]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_IsDel]  DEFAULT ((0)) FOR [IsDel]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_IsAppr]  DEFAULT ((1)) FOR [IsAppr]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_CrDtSys]  DEFAULT (getdate()) FOR [CrDtSys]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_IsMod]  DEFAULT ((0)) FOR [IsMod]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_ModCount]  DEFAULT ((0)) FOR [ModCount]
GO

ALTER TABLE [dbo].[BuySell] ADD  CONSTRAINT [DF_BuySell_ModDtSys]  DEFAULT (getdate()) FOR [ModDtSys]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_Priority]  DEFAULT ((0)) FOR [Priority]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_IsDel]  DEFAULT ((0)) FOR [IsDel]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_IsAppr]  DEFAULT ((1)) FOR [IsAppr]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_CrDtSys]  DEFAULT (getdate()) FOR [CrDtSys]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_IsMod]  DEFAULT ((0)) FOR [IsMod]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_ModCount]  DEFAULT ((0)) FOR [ModCount]
GO

ALTER TABLE [dbo].[BuySellReply] ADD  CONSTRAINT [DF_BuySellReply_ModDtSys]  DEFAULT (getdate()) FOR [ModDtSys]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_Priority]  DEFAULT ((0)) FOR [Priority]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_IsDel]  DEFAULT ((0)) FOR [IsDel]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_IsAppr]  DEFAULT ((1)) FOR [IsAppr]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_CrDtSys]  DEFAULT (getdate()) FOR [CrDtSys]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_IsMod]  DEFAULT ((0)) FOR [IsMod]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_ModCount]  DEFAULT ((0)) FOR [ModCount]
GO

ALTER TABLE [dbo].[Help] ADD  CONSTRAINT [DF_Help_ModDtSys]  DEFAULT (getdate()) FOR [ModDtSys]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_Priority]  DEFAULT ((0)) FOR [Priority]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_IsDel]  DEFAULT ((0)) FOR [IsDel]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_IsAppr]  DEFAULT ((1)) FOR [IsAppr]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_CrDtSys]  DEFAULT (getdate()) FOR [CrDtSys]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_IsMod]  DEFAULT ((0)) FOR [IsMod]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_ModCount]  DEFAULT ((0)) FOR [ModCount]
GO

ALTER TABLE [dbo].[HelpReply] ADD  CONSTRAINT [DF_HelpReply_ModDtSys]  DEFAULT (getdate()) FOR [ModDtSys]
GO

