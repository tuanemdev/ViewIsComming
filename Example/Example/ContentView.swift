import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Angular") {
                    AngularView()
                }
                NavigationLink("BookFlip") {
                    BookFlipView()
                }
                NavigationLink("Bounce") {
                    BounceView()
                }
                NavigationLink("BowTie") {
                    BowTieView()
                }
                NavigationLink("Burn") {
                    BurnView()
                }
                NavigationLink("ButterflyWaveScrawler") {
                    ButterflyWaveScrawlerView()
                }
                NavigationLink("CircleCrop") {
                    CircleCropView()
                }
                NavigationLink("CornerVanish") {
                    CornerVanishView()
                }
                NavigationLink("CrazyParametric") {
                    CrazyParametricView()
                }
                NavigationLink("CrossHatch") {
                    CrossHatchView()
                }
                NavigationLink("CrossZoom") {
                    CrossZoomView()
                }
                NavigationLink("Cube") {
                    CubeView()
                }
                NavigationLink("Directional") {
                    DirectionalView()
                }
                NavigationLink("DirectionalWipe") {
                    DirectionalWipeView()
                }
                NavigationLink("DoomScreen") {
                    DoomScreenView()
                }
                NavigationLink("Doorway") {
                    DoorwayView()
                }
                
                NavigationLink {
                    DreamyView()
                } label: {
                    Text("Dreamy")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    DreamyZoomView()
                } label: {
                    Text("Dreamy Zoom")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FadeView()
                } label: {
                    Text("Fade")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FadeColorView()
                } label: {
                    Text("Fade Color")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FadeGrayscaleView()
                } label: {
                    Text("Fade Grayscale")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FilmBurnView()
                } label: {
                    Text("Film Burn")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FlipView()
                } label: {
                    Text("Flip")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FlowerView()
                } label: {
                    Text("Flower")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FlyEyeView()
                } label: {
                    Text("Fly Eye")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    FoldView()
                } label: {
                    Text("Fold")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    GlitchDisplaceView()
                } label: {
                    Text("Glitch Displace")
                        .foregroundColor(.red)
                }
                
                NavigationLink("GlitchMemories") {
                    GlitchMemoriesView()
                }
                
                NavigationLink {
                    GridFlipView()
                } label: {
                    Text("Grid Flip")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    HeartView()
                } label: {
                    Text("Heart")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    HexagonalizeView()
                } label: {
                    Text("Hexagonalize")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    HorizontalOpenView()
                } label: {
                    Text("Horizontal Open")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    InterferenceView()
                } label: {
                    Text("Interference")
                        .foregroundColor(.red)
                }
                NavigationLink("InvertedPageCurl") {
                    InvertedPageCurlView()
                }
                NavigationLink {
                    KaleidoscopeView()
                } label: {
                    Text("Kaleidoscope")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    LinearBlurView()
                } label: {
                    Text("Linear Blur")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    LuminanceMeltView()
                } label: {
                    Text("Luminance Melt")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    MorphView()
                } label: {
                    Text("Morph")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    MosaicView()
                } label: {
                    Text("Mosaic")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    MotionBlurView()
                } label: {
                    Text("Motion Blur")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    MultiplyBlendView()
                } label: {
                    Text("Multiply Blend")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    OverexposureView()
                } label: {
                    Text("Overexposure")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    PageCurlView()
                } label: {
                    Text("Page Curl")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    PerlinView()
                } label: {
                    Text("Perlin")
                        .foregroundColor(.red)
                }
                NavigationLink("PinWheel") {
                    PinWheelView()
                }
                NavigationLink {
                    PixelizeView()
                } label: {
                    Text("Pixelize")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    PolarFunctionView()
                } label: {
                    Text("Polar Function")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    PolkaDotsCurtainView()
                } label: {
                    Text("PolkaDots Curtain")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    PowerKaleidoView()
                } label: {
                    Text("Power Kaleido")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RadialView()
                } label: {
                    Text("Radial")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RadialBlurView()
                } label: {
                    Text("Radial Blur")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RandomNoiseView()
                } label: {
                    Text("Random Noise")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RandomSquaresView()
                } label: {
                    Text("Random Squares")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RectangleView()
                } label: {
                    Text("Rectangle")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RippleView()
                } label: {
                    Text("Ripple")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RotateView()
                } label: {
                    Text("Rotate")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RotateScaleFadeView()
                } label: {
                    Text("Rotate Scale Fade")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RotateScaleVanishView()
                } label: {
                    Text("Rotate Scale Vanish")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    RotateTransitionView()
                } label: {
                    Text("Rotate Transition")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    ScaleInView()
                } label: {
                    Text("Scale In")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    SimpleBookCurlView()
                } label: {
                    Text("Simple Book Curl")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    SimpleZoomView()
                } label: {
                    Text("Simple Zoom")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    SlideView()
                } label: {
                    Text("Slide")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    SpinView()
                } label: {
                    Text("Spin")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    SpiralView()
                } label: {
                    Text("Spiral")
                        .foregroundColor(.red)
                }
                NavigationLink("SquaresWire") {
                    SquaresWireView()
                }
                NavigationLink {
                    SqueezeView()
                } label: {
                    Text("Squeeze")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    StaticFadeView()
                } label: {
                    Text("Static Fade")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    StaticWipeView()
                } label: {
                    Text("Static Wipe")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    StereoViewerView()
                } label: {
                    Text("Stereo Viewer")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    SwapView()
                } label: {
                    Text("Swap")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    SwirlView()
                } label: {
                    Text("Swirl")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    TangentMotionBlurView()
                } label: {
                    Text("Tangent Motion Blur")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    TilesView()
                } label: {
                    Text("Tiles")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    TVStaticView()
                } label: {
                    Text("TV Static")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    TwistedScaleView()
                } label: {
                    Text("Twisted Scale")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    UndulatingBurnOutView()
                } label: {
                    Text("Undulating Burn Out")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    VerticalOpenView()
                } label: {
                    Text("Vertical Open")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    VHSView()
                } label: {
                    Text("VHS")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    WaterDropView()
                } label: {
                    Text("Water Drop")
                        .foregroundColor(.red)
                }
                NavigationLink {
                    WaterfallView()
                } label: {
                    Text("Waterfall")
                        .foregroundColor(.red)
                }
                
                NavigationLink("Wave") {
                    WaveView()
                }
                NavigationLink("Wind") {
                    WindView()
                }
                NavigationLink("WindowBlinds") {
                    WindowBlindsView()
                }
                NavigationLink("WindowSlice") {
                    WindowSliceView()
                }
            }
            .navigationTitle("View Is Comming")
        }
    }
}

#Preview {
    ContentView()
}
