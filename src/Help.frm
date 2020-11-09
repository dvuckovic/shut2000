VERSION 5.00
Begin VB.Form Help 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "shut2ooo"
   ClientHeight    =   1905
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   1635
   ControlBox      =   0   'False
   Icon            =   "Help.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1905
   ScaleWidth      =   1635
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.CommandButton Shutdown 
      Caption         =   "   -S       <&Shut down>"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   30
      TabIndex        =   3
      Top             =   900
      Width           =   1590
   End
   Begin VB.CommandButton Restart 
      Caption         =   "-R         <&Restart>"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   30
      TabIndex        =   2
      Top             =   570
      Width           =   1590
   End
   Begin VB.CommandButton Logoff 
      Caption         =   "-L          <&Log off>"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   30
      TabIndex        =   1
      Top             =   240
      Width           =   1590
   End
   Begin VB.CommandButton Patsy 
      Height          =   255
      Left            =   2040
      TabIndex        =   0
      Top             =   720
      Width           =   255
   End
   Begin VB.CommandButton Ok 
      Caption         =   "&Ok"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   30
      TabIndex        =   4
      Top             =   1605
      Width           =   1590
   End
   Begin VB.Label Link 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "http://cuzcko.cjb.net"
      DragIcon        =   "Help.frx":0E42
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   165
      Left            =   210
      TabIndex        =   7
      Top             =   1380
      Width           =   1245
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "(d) by dUcA 2oo2"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   165
      Left            =   300
      TabIndex        =   6
      Top             =   1230
      Width           =   1065
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Command line switches:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   165
      Left            =   75
      TabIndex        =   5
      Top             =   30
      Width           =   1500
   End
End
Attribute VB_Name = "Help"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Type LUID
    UsedPart As Long
    IgnoredForNowHigh32BitPart As Long
End Type
Private Type TOKEN_PRIVILEGES
    PrivilegeCount As Long
    TheLuid As LUID
    Attributes As Long
End Type
Private Declare Function ExitWindowsEx Lib "user32" (ByVal dwOptions As Long, ByVal dwReserved As Long) As Long
Private Declare Function GetCurrentProcess Lib "kernel32" () As Long
Private Declare Function OpenProcessToken Lib "advapi32" (ByVal ProcessHandle As Long, ByVal DesiredAccess As Long, TokenHandle As Long) As Long
Private Declare Function LookupPrivilegeValue Lib "advapi32" Alias "LookupPrivilegeValueA" (ByVal lpSystemName As String, ByVal lpName As String, lpLuid As LUID) As Long
Private Declare Function AdjustTokenPrivileges Lib "advapi32" (ByVal TokenHandle As Long, ByVal DisableAllPrivileges As Long, NewState As TOKEN_PRIVILEGES, ByVal BufferLength As Long, PreviousState As TOKEN_PRIVILEGES, ReturnLength As Long) As Long
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Sub AdjustToken()
    Const TOKEN_ADJUST_PRIVILEGES = &H20
    Const TOKEN_QUERY = &H8
    Const SE_PRIVILEGE_ENABLED = &H2
    Dim hdlProcessHandle As Long
    Dim hdlTokenHandle As Long
    Dim tmpLuid As LUID
    Dim tkp As TOKEN_PRIVILEGES
    Dim tkpNewButIgnored As TOKEN_PRIVILEGES
    Dim lBufferNeeded As Long
    hdlProcessHandle = GetCurrentProcess()
    OpenProcessToken hdlProcessHandle, (TOKEN_ADJUST_PRIVILEGES Or TOKEN_QUERY), hdlTokenHandle
    LookupPrivilegeValue "", "SeShutdownPrivilege", tmpLuid
    tkp.PrivilegeCount = 1
    tkp.TheLuid = tmpLuid
    tkp.Attributes = SE_PRIVILEGE_ENABLED
    AdjustTokenPrivileges hdlTokenHandle, False, tkp, Len(tkpNewButIgnored), tkpNewButIgnored, lBufferNeeded
End Sub
Private Sub Form_Load()
    AdjustToken
    If Len(Command$) = 2 Then
        Dim Switch
        Select Case LCase(Command$)
            Case "-l"
                Switch = "0"
            Case "-r"
                Switch = "2"
            Case "-s"
                Switch = "9"
        End Select
        If Switch = "" Then
            Help.Show
        Else
            ExitWindowsEx (Switch), &HFFFF
            Unload Me
            End
        End If
    Else
        Help.Show
    End If
End Sub
Private Sub Logoff_Click()
    ExitWindowsEx (0), &HFFFF
    Unload Me
    End
End Sub
Private Sub Restart_Click()
    ExitWindowsEx (2), &HFFFF
    Unload Me
    End
End Sub
Private Sub Shutdown_Click()
    ExitWindowsEx (9), &HFFFF
    Unload Me
    End
End Sub
Private Sub Link_DragDrop(Source As Control, X As Single, Y As Single)
    If Source Is Link Then
        With Link
            .Font.Underline = False
            .ForeColor = vbBlack
            Call ShellExecute(0&, vbNullString, .Caption, vbNullString, vbNullString, vbNormalFocus)
        End With
    End If
End Sub
Private Sub Link_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    If State = vbLeave Then
        With Link
            .Drag vbEndDrag
            .Font.Underline = False
            .ForeColor = vbBlack
        End With
    End If
End Sub
Private Sub Link_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    With Link
        .ForeColor = vbBlue
        .Font.Underline = True
        .Drag vbBeginDrag
    End With
End Sub
Private Sub Ok_Click()
    Unload Me
    End
End Sub
