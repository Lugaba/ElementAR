import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    
    let pdfDocument: PDFDocument
    
    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }
    
    //you could also have inits that take a URL or Data
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}

struct PDFUIView: View {
    
    var pdfDoc: PDFDocument?
    let url: URL?
    
    init(name: String) {
        url = Bundle.main.url(forResource: name, withExtension: "pdf")
        if let url = url {
            self.pdfDoc = PDFDocument(url: url)
        }
        
    }
    
    var body: some View {
        if let pdfDoc = pdfDoc {
            PDFKitView(showing: pdfDoc)
                .navigationTitle("PDF")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button(action: actionSheet) {
                        Image(systemName: "square.and.arrow.up").imageScale(.large)
                    }
                }
        }
    }
    
    func actionSheet() {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct PDFUIView_Previews: PreviewProvider {
    static var previews: some View {
        PDFUIView(name: "Lipsum")
    }
}
