/**
 * Ambient animated cosmic gradient — slow, calm, AI-lab atmosphere.
 * Smooth interpolation, no harsh stop shifting. Pure CSS for GPU perf.
 */
export const BgGradient = () => {
  return (
    <div className="fixed inset-0 -z-10 overflow-hidden pointer-events-none bg-[#050816]">
      {/* Slowly rotating conic-like layered linear gradient */}
      <div
        className="absolute -inset-[40%] animate-bg-rotate opacity-90"
        style={{
          background:
            'linear-gradient(135deg, #050816 0%, #0a0a1f 18%, #140B2D 34%, #2E1A5E 52%, #4a1d6e 68%, #6B2C6E 82%, #B5179E 100%)',
          filter: 'blur(40px)',
        }}
      />
      {/* Counter-rotating soft neural glow layer */}
      <div
        className="absolute -inset-[30%] animate-bg-rotate-reverse opacity-50 mix-blend-screen"
        style={{
          background:
            'radial-gradient(ellipse at 30% 40%, rgba(0,201,167,0.18) 0%, transparent 55%), radial-gradient(ellipse at 70% 65%, rgba(0,124,240,0.20) 0%, transparent 55%), radial-gradient(ellipse at 50% 50%, rgba(181,23,158,0.15) 0%, transparent 60%)',
          filter: 'blur(60px)',
        }}
      />
      {/* Subtle vignette to ground content */}
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,_transparent_40%,_rgba(5,8,22,0.65)_100%)]" />
    </div>
  );
};
