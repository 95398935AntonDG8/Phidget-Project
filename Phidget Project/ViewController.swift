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
                print("LED 3 Attached")
            }
            else{
                print("Button 0 Attached")
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
                try led.setState(true)
            }
            else{
                print("Button Not Pressed")
                try led.setState(false)
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            //enable server discovery
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            //address objects
            try led.setDeviceSerialNumber(528005)
            try led.setHubPort(2)
            try led.setIsHubPortDevice(true)
            
            try button0.setDeviceSerialNumber(528005)
            try button0.setHubPort(0)
            try button0.setIsHubPortDevice(true)
            
            try button1.setDeviceSerialNumber(528005)
            try button1.setHubPort(1)
            try button1.setIsHubPortDevice(true)
            
            //add attach handlers
            let _ = led.attach.addHandler(attach_handler)
            let _ = button0.attach.addHandler(attach_handler)
            let _ = button1.attach.addHandler(attach_handler)
            
            //add state change handler
            let _ = button0.stateChange.addHandler(state_change)
            let _ = button1.stateChange.addHandler(state_change)
            
            
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


