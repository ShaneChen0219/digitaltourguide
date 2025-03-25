import SwiftUI
import CoreData

class AudioViewModel: ObservableObject {
    // Reference to the Core Data context
    private let viewContext: NSManagedObjectContext
    
    // Published list of items for the UI
    @Published var audioItems: [Audio] = []
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchAudioItems()  // Load items at initialization
    }
    
    // MARK: - Fetch
    func fetchAudioItems() {
        let request: NSFetchRequest<Audio> = Audio.fetchRequest()
        // Example sort: by title ascending
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Audio.title, ascending: true)]
        
        do {
            let items = try viewContext.fetch(request)
            self.audioItems = items
        } catch {
            print("Error fetching items: \(error)")
        }
    }
    
    // MARK: - Add
    func addAudio(title: String, audioURL: String?, localFilePath: String?) {
        let newItem = Audio(context: viewContext)
        newItem.id = UUID()           // Non-optional UUID
        newItem.title = title
        newItem.audioURL = audioURL
        newItem.localFilePath = localFilePath
        newItem.viewCount = 0        // Start at 0
        
        saveContext()
        fetchAudioItems() // Refresh
    }
    
    // MARK: - Increment View Count
    func incrementViewCount(for item: Audio) {
        item.viewCount += 1
        saveContext()
        // Depending on your UI, you might call fetchAudioItems() to refresh, or rely on SwiftUI’s observation.
    }
    
    // MARK: - Delete
    func deleteItem(_ item: Audio) {
        viewContext.delete(item)
        saveContext()
        fetchAudioItems()
    }
    
    // MARK: - Save
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
