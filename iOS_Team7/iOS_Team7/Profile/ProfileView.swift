import UIKit

class ProfileView: UIView {
    var nameField: UILabel!
    var emailField: UILabel!
    var logoutBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the background color
        self.backgroundColor = .white
        
       // setupNameField()
        setupEmailField()
        setupLogoutButton()
        
        initConstraints()
    }
    
    func setupNameField() {
        nameField = UILabel()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.textColor = .black
        nameField.textAlignment = .center // Adjust text alignment if needed
        nameField.font = UIFont.systemFont(ofSize: 20) // Adjust font size if needed
        nameField.text = "User Name" // Set default text
        self.addSubview(nameField)
    }
    
    func setupEmailField() {
        emailField = UILabel()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.textColor = .black
        emailField.textAlignment = .center // Adjust text alignment if needed
        emailField.font = UIFont.systemFont(ofSize: 16) // Adjust font size if needed
        emailField.text = "user@example.com" // Set default text
        self.addSubview(emailField)
    }
    
    func setupLogoutButton() {
        logoutBtn = UIButton(type: .roundedRect)
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.backgroundColor = .black
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.setTitleColor(.white, for: .normal)
        logoutBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(logoutBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
    
            
            logoutBtn.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            logoutBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoutBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logoutBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
