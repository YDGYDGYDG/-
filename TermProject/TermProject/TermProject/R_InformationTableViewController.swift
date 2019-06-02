//
//  R_InformationTableViewController.swift
//  TermProject
//
//  Created by kpugame on 2019. 5. 30..
//  Copyright © 2019년 YDK. All rights reserved.
//

import UIKit

class R_InformationTableViewController: UITableViewController, XMLParserDelegate {
    
    @IBOutlet var detailTableView: UITableView!
    
    var url: String?
    var parser = XMLParser()
    
    let postsname : [String] = ["업소명", "업종", "주소(지번)", "주소(도로명)", "개업일", "운영 여부"]
    var posts : [String] = ["","","","","",""]
    
    var position = NSMutableArray()
    
    var element = NSString()
    
    var yadmNm = NSMutableString()
    var addr = NSMutableString()
    var telno = NSMutableString()
    var hospUrl = NSMutableString()
    var clCdNm = NSMutableString()
    var estbDd = NSMutableString()
    
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf: (URL(string: url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item"){
            posts = ["","","","","",""]
            
            yadmNm = NSMutableString()
            yadmNm = ""
            addr = NSMutableString()
            addr = ""
            telno = NSMutableString()
            telno = ""
            hospUrl = NSMutableString()
            hospUrl = ""
            clCdNm = NSMutableString()
            clCdNm = ""
            estbDd = NSMutableString()
            estbDd = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "BIZPLC_NM"){
            yadmNm.append(string)
        }
        else if element.isEqual(to: "SANITTN_BIZCOND_NM"){
            addr.append(string)
            
        }
        else if element.isEqual(to: "REFINE_LOTNO_ADDR"){
            telno.append(string)
            
        }
        else if element.isEqual(to: "REFINE_ROADNM_ADDR"){
            hospUrl.append(string)
            
        }
        else if element.isEqual(to: "LICENSG_DE"){
            clCdNm.append(string)
            
        }
        else if element.isEqual(to: "BSN_STATE_NM"){
            estbDd.append(string)
            
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "item"){
            if !yadmNm.isEqual(nil){
                posts[0] = yadmNm as String
            }
            if !addr.isEqual(nil){
                posts[1] = addr as String
            }
            if !telno.isEqual(nil){
                posts[2] = telno as String
            }
            if !hospUrl.isEqual(nil){
                posts[3] = hospUrl as String
            }
            if !clCdNm.isEqual(nil){
                posts[4] = clCdNm as String
            }
            if !estbDd.isEqual(nil){
                posts[5] = estbDd as String
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestorantCell", for: indexPath)
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMapView"{
            if let mapViewController = segue.destination as? R_MapViewController{
                mapViewController.posts = position
            }
        }
    }
}
