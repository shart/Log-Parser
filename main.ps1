# Import LogCleaner module 
# Check if Irregular module is installed
if (-not (Get-Module -ListAvailable -Name Irregular)) {

  # Not installed, install from gallery
  Write-Host "Irregular module not found, installing..."
  Install-Module -Name Irregular -Scope CurrentUser -Force

  # Import the installed module
  Import-Module Irregular

}
else {

  # Already installed, just import
  Import-Module Irregular

}
Import-Module .\LogCleaner.psm1

# Load Windows Forms assembly
[void][Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

# Create form 
$form = New-Object Windows.Forms.Form

# Set form properties
$form.Text = "Log File Cleaner"
$form.Size = New-Object Drawing.Size @(400,200) 

# Add FlowDirection property to form
Add-Member -InputObject $form -MemberType NoteProperty -Name FlowDirection -Value "RightToLeft"

# Set FormBorderStyle 
$form.FormBorderStyle = 'FixedDialog'

# Set FlowDirection  
$form.FlowDirection = 'RightToLeft'

# Rest of button code...

# Create label
$label = New-Object Windows.Forms.Label
$label.Location = New-Object Drawing.Point @(20,20) 
$label.Size = New-Object Drawing.Size @(280,20)
$label.Text = "Select a log file to clean:"
$form.Controls.Add($label)

# Create text box for file path
$textBox = New-Object Windows.Forms.TextBox 
$textBox.Location = New-Object Drawing.Point @(20,50)
$textBox.Size = New-Object Drawing.Size @(260,20)
$form.Controls.Add($textBox)

# Create browse button
$button = New-Object Windows.Forms.Button
$button.Location = New-Object Drawing.Point @(290,50)
$button.Size = New-Object Drawing.Size @(80,20)
$button.Text = "Browse"
$form.Controls.Add($button) 

# Add click handler for browse button
$button.Add_Click({
  # Show file browser dialog
  $dialog = New-Object Windows.Forms.OpenFileDialog
  $dialog.Filter = "Text Files (*.txt)|*.txt"
  if($dialog.ShowDialog() -eq [Windows.Forms.DialogResult]::OK) {
    $textBox.Text = $dialog.FileName 
  }
})

# Create clean button
$cleanButton = New-Object Windows.Forms.Button
$cleanButton.Location = New-Object Drawing.Point @(20,80)
$cleanButton.Size = New-Object Drawing.Size @(350,40)
$cleanButton.Text = "Clean File"
$form.Controls.Add($cleanButton)

# Add click handler to call LogCleaner
$cleanButton.Add_Click({
  Clean-Log -LogFileName $textBox.Text


  [Windows.Forms.MessageBox]::Show("Log file cleaned!")
  $form.Text = "Cleaning Complete!"
})

# Create close button 
$closeButton = New-Object Windows.Forms.Button
$closeButton.Location = New-Object Drawing.Point @(20,120) 
$closeButton.Size = New-Object Drawing.Size @(80,30)
$closeButton.Text = "Close"
$form.Controls.Add($closeButton)

# Add click handler to close form
$closeButton.Add_Click({
  $form.Close()
})

# Adjust clean button location
$cleanButton.Location = New-Object Drawing.Point @(250,80)
$cleanButton.Size = New-Object Drawing.Size @(150,40)

# Adjust close button location 
$closeButton.Location = New-Object Drawing.Point @(120,80)
$closeButton.Size = New-Object Drawing.Size @(100,40)



# Show form
$form.ShowDialog()
