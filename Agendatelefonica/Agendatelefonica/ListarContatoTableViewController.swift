//
//  ListarContatoTableViewController.swift
//  Agendatelefonica
//
//  Created by Macos on 05/12/22.
//

import UIKit
import CoreData

class ListarContatoTableViewController: UITableViewController {

    var context : NSManagedObjectContext!
    var contatos : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recuperarContatos()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext

        
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        recuperarContatos()
    }*/
    
    func recuperarContatos(){
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
        
        let ordenacao = NSSortDescriptor(key: "nome", ascending: true)
        
        requisicao.sortDescriptors = [ordenacao]
        
        do {
            let contatosRecuperados = try context.fetch(requisicao)
            self.contatos = contatosRecuperados as! [NSManagedObject]
            self.tableView.reloadData()
            
            /*if contatosRecuperados.count > 0 {
                for contatoRec in contatosRecuperados as! [NSManagedObject] {
                    if let nome = contatoRec.value(forKey: "nome") {
                        if let celular = contatoRec.value(forKey: "celular") {
                            print(String(describing: nome) + " - " + String(describing: celular))
                        }
                    }
                }
            }*/
        } catch let erro {
            print("Erro ao recuperar contatos: \(erro.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contatos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        let contato = self.contatos[indexPath.row]
        let nomeRecuperado = contato.value(forKey: "nome")
        let celularRecuperado = contato.value(forKey: "celular")
        
        cell.textLabel?.text = String(describing: nomeRecuperado)
        cell.detailTextLabel?.text = String(describing: celularRecuperado)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
