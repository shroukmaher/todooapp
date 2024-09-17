import 'package:cloud_firestore/cloud_firestore.dart';

import 'Todo_DM.dart';

class TaskDao{

   static Future getTodo() async{
    CollectionReference todosCollection=FirebaseFirestore.instance.collection(TodoDM.collectionName);
    var taskSnapshot=  await todosCollection.snapshots();
    var  snapShot=
    taskSnapshot.map((snapShot)=>snapShot.docs.map(
            (e)=>e.data()).toList());
    return snapShot;

  }


   static Future <void> updateTodo(TodoDM task) async{
    CollectionReference todosCollection=FirebaseFirestore.instance.collection(TodoDM.collectionName);
    var taskdoc=todosCollection.doc(task.id);
    await taskdoc.update(task.toJson());
  }


  static Future<void> deleteNote(String taskID) async{
    CollectionReference todosCollection=FirebaseFirestore.instance.collection(TodoDM.collectionName);
    var noteDoc=todosCollection.doc(taskID);
    await noteDoc.delete();
  }
}