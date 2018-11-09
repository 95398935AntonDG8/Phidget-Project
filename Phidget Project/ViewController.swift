import UIKit
import Phidget22Swift

class ViewController: UIViewController {

    let led2 = DigitalOutput()
    let led3 = DigitalOutput()
    let button0 = DigitalInput()
    let button1 = DigitalInput()
    
    func attach_handler(sender: Phidget){
        do{
            if(try sender.getHubPort() == 0){
                print("LED 2 Attached")
            }
            else{
                print("Button 0 Attached")
            }
            if(try sender.getHubPort() == 1){
                print("LED 3 Attached")
            }
            else{
                print("Button 1 Attached")
            }
            
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    func state_change(sender:DigitalInput, state:Bool){
        do{
            if(state == true){
                print("Button Pressed")
                try led2.setState(true)
            }
            else{
                print("Button Not Pressed")
                try led2.setState(false)
            }
            if(state == false){
                print("Button Pressed")
                try led3.setState(true)
            }
            else{
                print("Button Not Pressed")
                try led3.setState(false)
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }

    @IBAction func P1(_ sender: UIButton) {
    }
    
    @IBAction func P2(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            //enable server discovery
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            //address objects
            try led2.setDeviceSerialNumber(528005)
            try led2.setHubPort(2)
            try led2.setIsHubPortDevice(true)
            
            try led3.setDeviceSerialNumber(528005)
            try led3.setHubPort(3)
            try led3.setIsHubPortDevice(true)
            
            try button0.setDeviceSerialNumber(528005)
            try button0.setHubPort(0)
            try button0.setIsHubPortDevice(true)
            
            try button1.setDeviceSerialNumber(528005)
            try button1.setHubPort(1)
            try button1.setIsHubPortDevice(true)
            
            //add attach handlers
            let _ = led2.attach.addHandler(attach_handler)
            let _ = led3.attach.addHandler(attach_handler)
            let _ = button0.attach.addHandler(attach_handler)
            let _ = button1.attach.addHandler(attach_handler)
            
            //add state change handler
            let _ = button0.stateChange.addHandler(state_change)
            let _ = button1.stateChange.addHandler(state_change)
            
            //open objects
            try button0.open()
            try button1.open()
            try led2.open()
            try led3.open()
            
        } catch let err as PhidgetError {
            print("Phidget Error" + err.description)
        } catch {
            //catch other errors here
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


