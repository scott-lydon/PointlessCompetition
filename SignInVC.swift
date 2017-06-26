
import UIKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        //frames are obsolete please use constraints instead. Why don't frames make sense now a days? 
        
        loginButton.frame = CGRect(x: 16, y: 100, width: view.frame.width - 32, height: 50)

        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        //add our custom fb login button here
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .blue
        customFBButton.frame = CGRect(x: 16, y: 166, width: view.frame.width - 32, height: 50)
        customFBButton.setTitle("Custom FB Login here", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor(.white, for: .normal)
        view.addSubview(customFBButton)
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }
    
    
    
    func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self)
        { (result, err) in
            if err != nil {
                print("Custom FB Login failed", err ?? "")
                return
            }
            self.showEmailAddress()
            print(result?.token.tokenString ?? "")
            
          
        }
    }//handle custom fb login
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("successfuly logged in with facebook, we have access to the facebook data, and an id code")
        showEmailAddress()
    }

    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard (accessToken?.tokenString) != nil else
        { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: (accessToken?.tokenString)!)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil {
                print("something went wrong with our FB user: ", error ?? "")
                return
            }
            
            print("Successfully logged in with our user: ", user ?? "")
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            print(123)
            
            if err != nil {
                print("Failed to start graph request", err ?? "error was nil")
                return
            }
            
            print("RESULT IS HERE: \(String(describing: result))" )
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "button") as! ViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }//FBSDKGraphRequest
    }
}// VC
