//
//  ViewController.swift
//  Agendatelefonica
//
//  Created by Macos on 05/12/22.
//

import UIKit

import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var textoNome: UITextField!
    
    @IBOutlet weak var textoCelular: UITextField!
    
    @IBOutlet weak var textoTelefone: UITextField!
    
    @IBOutlet weak var textoEmail: UITextField!
    
    var context : NSManagedObjectContext!
    var nome : NSManagedObject!
    var celular : NSManagedObject!
    var telefone : NSManagedObject!
    var email : NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textoNome.becomeFirstResponder()
        self.textoCelular.becomeFirstResponder()
        self.textoTelefone.becomeFirstResponder()
        self.textoEmail.becomeFirstResponder()
        
        if nome != nil {
            if  let nomeRecuperado = nome.value(forKey: "textoNome") {
                self.textoNome.text = String(describing: nomeRecuperado)
            }
        } else {
            self.textoNome.text = ""
        }
        
        if celular != nil {
            if  let celularRecuperado = celular.value(forKey: "textoCelular") {
                self.textoCelular.text = String(describing: celularRecuperado)
            }
        } else {
            self.textoCelular.text = ""
        }
        
        if telefone != nil {
            if  let telefoneRecuperado = telefone.value(forKey: "textoTelefone") {
                self.textoTelefone.text = String(describing: telefoneRecuperado)
            }
        } else {
            self.textoTelefone.text = ""
        }
        
        if email != nil {
            if  let emailRecuperado = email.value(forKey: "textoEmail") {
                self.textoEmail.text = String(describing: emailRecuperado)
            }
        } else {
            self.textoEmail.text = ""
        }
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        
    }

    @IBAction func salvar(_ sender: Any) {
        if nome == nil {
            self.salvarContato()
        } else {
            self.editarContato()
        }
        self.navigationController?.popViewController(animated: false)
    }
    
    func salvarContato() {
        let novoContato = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: context)
        
        novoContato.setValue(self.textoNome.text, forKey: "nome")
        novoContato.setValue(self.textoCelular.text, forKey: "celular")
        novoContato.setValue(self.textoTelefone.text, forKey: "telefone")
        novoContato.setValue(self.textoEmail.text, forKey: "email")
        
        do {
            try context.save()
            print("Contato salvo com sucesso!")
        } catch let erro {
            print("Erro ao salvar contato: \(erro.localizedDescription)")
        }
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
        
        let ordenacao = NSSortDescriptor(key: "nome", ascending: true)
        
        requisicao.sortDescriptors = [ordenacao]
        
        do {
            let contatosRecuperados = try context.fetch(requisicao)            
            if contatosRecuperados.count > 0 {
                for contatoRec in contatosRecuperados as! [NSManagedObject] {
                    if let nome = contatoRec.value(forKey: "nome") {
                        if let celular = contatoRec.value(forKey: "celular") {
                            print(String(describing: nome) + " - " + String(describing: celular))
                        }
                    }
                }
            }
        } catch let erro {
            print("Erro ao recuperar contatos: \(erro.localizedDescription)")
        }
        
        
    }
    
    func editarContato() {
        let editContato = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: context)
        editContato.setValue(self.textoNome.text, forKey: "nome")
        editContato.setValue(self.textoCelular.text, forKey: "celular")
        editContato.setValue(self.textoTelefone.text, forKey: "telefone")
        editContato.setValue(self.textoEmail.text, forKey: "email")
        
        do {
            try context.save()
            print("Contato editado com sucesso!")
        } catch let erro {
            print("Erro ao editado contato: \(erro.localizedDescription)")
        }
    }
    
}

