
//アカウント管理クラス
class AccountManager{
    
    var myAccount : account = account.init(Name: "MyName", id: "id", Message: "message", StarType: 0, familier: 0)
    //友達一覧
    var friends : [account] = [];
    //友達最大数
    var friendMax : Int = 20;
    //友達ファイルの先頭名
    let friendFileName = "friend_"
    //自分のアカウントのファイル名
    let myAccountFileName = "myAccount"
    
    static func MakeNewID()->String{
        
        let length : Int = 40
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    //友達を一人追加（引数は追加するアカウント）
    func AddFriend(account:account){
        if(friends.count < friendMax){
            friends.append(account)
        }
    }
    
    //友達を一人削除（引数は削除するアカウントのID）
    func RemoveFriend(id :String) {
        
        for (index, friend) in friends.enumerated() {
            if(friend.ID == id){
                friends.remove(at: index)
            }
        }
    }
    
    //友達の情報を最新のものに更新（引数は取得可能なすべて（友達以外も含む）の最新のアカウント）
    func FreandsUpdate(newAcountDatas : [account]){
        
        for newAcountData in newAcountDatas {
            for (index, friend) in friends.enumerated(){
                if(newAcountData.ID == friend.ID){
                    friends[index] = newAcountData
                    friends[index].Familier += 1
                }
            }
        }
    }
    
    //ファイル保存先のURL
    func FileURL()-> URL?{
        return FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first
    }
    
    //ファイル保存先のPath
    func FilePath()-> String{
        return NSHomeDirectory() + "/Documents"
    }
    
    //保存されているすべての友達情報ファイル名
    func GetFriendFileNames()-> [String]{
        
        let fileManager = FileManager.default
        var files: [String] = []
        
        do{
            files = try fileManager.contentsOfDirectory(atPath: FilePath())
            
        } catch{
            return []
        }
        
        return files.filter{$0.contains(friendFileName)}
        
    }
    
    //自分のアカウントをファイルとして保存
    func SaveMyAccount(){
        
        let fileName : String = myAccountFileName + ".json"
        let text : String = encode(account: myAccount)
        if let dir = FileURL(){
            
            let pathFileName = dir.appendingPathComponent( fileName )
            
            do{
                try text.write( to: pathFileName, atomically: false, encoding: String.Encoding.utf8 )
            }catch{
            }
        }
    }
    
    //ファイルから自分のアカウントを読み込む(存在していればtrue,存在しなければfalse)
    func LoadMyAccount() -> Bool{
        
        let fileName : String = myAccountFileName + ".json"
        if let dir = FileURL(){
            
            let pathFileName = dir.appendingPathComponent( fileName )
            
            let manager = FileManager()
            if(manager.fileExists(atPath: dir.absoluteString)){
                
                do{
                    let text = try String( contentsOf: pathFileName, encoding: String.Encoding.utf8 )
                    myAccount = decode(string:text)
                    return true
                }catch{
                    return false
                }
            }
        }
        return false;
    }
    //友達情報をファイルとして保存
    func SaveFreands(){
        
        let friendFiles = GetFriendFileNames()
        let manager = FileManager()
        for friend in friendFiles {
            
            do{
                try manager.removeItem(atPath: FilePath() + "/" + friend)
            }catch{
            }
        }
        
        for friend in friends {
            let fileName : String = friendFileName + friend.ID + ".json"
            let text : String = encode(account: friend)
            if let dir = FileURL(){
                
                let pathFileName = dir.appendingPathComponent( fileName )
                
                do{
                    try text.write( to: pathFileName, atomically: false, encoding: String.Encoding.utf8 )
                }catch{
                }
            }
        }
    }
    
    
    
    //ファイルから友達情報を読み込む
    func LoadFreands(){
        
        let friendFiles = GetFriendFileNames()
        
        friends.removeAll()
        
        for fileName in friendFiles {
            if let dir = FileURL(){
                
                let pathFileName = dir.appendingPathComponent( fileName )
                
                do{
                    let text = try String( contentsOf: pathFileName, encoding: String.Encoding.utf8 )
                    
                    friends.append(decode(string:text))
                    
                }catch{
                }
            }
        }
    }
    
    //アカウントクラスをJSON文字列に変換
    func encode(account : account) -> String{
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(account)
            let jsonstr : String = String(data: data, encoding: .utf8)!
            return jsonstr
            
        } catch {
            
            return ""
        }
    }
    
    //JSON文字列をアカウントクラスに変換
    func decode(string : String) -> account{
        
        let decoder = JSONDecoder()
        let acc : account = try! decoder.decode(account.self, from : string.data(using: .utf8)!)
        return acc
    }
}
