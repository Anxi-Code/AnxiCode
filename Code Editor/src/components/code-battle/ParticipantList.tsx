import { cn } from '@/lib/utils';
import { User, Users, Crown, Swords } from 'lucide-react';

interface Participant {
  id: string;
  name: string;
  team?: 'blue' | 'red';
  isLeader?: boolean;
  avatar?: string;
}

interface ParticipantListProps {
  participants: Participant[];
  mode: '1v1' | 'team';
  className?: string;
}

export const ParticipantList = ({ participants, mode, className }: ParticipantListProps) => {
  const blueTeam = participants.filter((p) => p.team === 'blue');
  const redTeam = participants.filter((p) => p.team === 'red');

  if (mode === '1v1') {
    return (
      <div className={cn("flex items-center gap-3", className)}>
        <ParticipantBadge participant={participants[0]} variant="blue" />
        <div className="flex items-center gap-1 text-muted-foreground animate-pulse">
          <Swords className="w-4 h-4 text-warning" />
          <span className="text-xs font-bold text-warning">VS</span>
        </div>
        <ParticipantBadge participant={participants[1]} variant="red" />
      </div>
    );
  }

  return (
    <div className={cn("flex items-center gap-4", className)}>
      <TeamGroup team={blueTeam} variant="blue" />
      <div className="flex items-center gap-1 text-muted-foreground animate-pulse">
        <Swords className="w-4 h-4 text-warning" />
        <span className="text-xs font-bold text-warning">VS</span>
      </div>
      <TeamGroup team={redTeam} variant="red" />
    </div>
  );
};

interface ParticipantBadgeProps {
  participant: Participant;
  variant: 'blue' | 'red';
}

const ParticipantBadge = ({ participant, variant }: ParticipantBadgeProps) => {
  return (
    <div
      className={cn(
        "flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-medium transition-all duration-300 cursor-default",
        "hover:scale-105 hover:-translate-y-0.5",
        variant === 'blue' && "bg-primary/20 text-primary border border-primary/30 hover:shadow-[0_0_20px_hsl(var(--primary)/0.3)] hover:border-primary/50",
        variant === 'red' && "bg-destructive/20 text-destructive border border-destructive/30 hover:shadow-[0_0_20px_hsl(var(--destructive)/0.3)] hover:border-destructive/50"
      )}
    >
      <div className="relative">
        <User className="w-4 h-4 transition-transform duration-200 group-hover:scale-110" />
        {participant.isLeader && (
          <Crown className="w-3 h-3 absolute -top-2 -right-1 text-warning animate-pulse" />
        )}
      </div>
      <span className="max-w-[100px] truncate">{participant.name}</span>
    </div>
  );
};

interface TeamGroupProps {
  team: Participant[];
  variant: 'blue' | 'red';
}

const TeamGroup = ({ team, variant }: TeamGroupProps) => {
  return (
    <div className="flex items-center gap-1">
      <Users
        className={cn(
          "w-4 h-4 mr-1",
          variant === 'blue' ? "text-primary" : "text-destructive"
        )}
      />
      <div className="flex -space-x-2">
        {team.map((participant, idx) => (
          <div
            key={participant.id}
            className={cn(
              "w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold border-2 transition-all duration-300 hover:scale-125 hover:z-10 cursor-default",
              variant === 'blue'
                ? "bg-primary/20 text-primary border-primary/50 hover:shadow-[0_0_15px_hsl(var(--primary)/0.4)] hover:border-primary"
                : "bg-destructive/20 text-destructive border-destructive/50 hover:shadow-[0_0_15px_hsl(var(--destructive)/0.4)] hover:border-destructive"
            )}
            style={{ zIndex: team.length - idx }}
            title={participant.name}
          >
            {participant.name.charAt(0).toUpperCase()}
          </div>
        ))}
      </div>
      <span
        className={cn(
          "text-xs font-semibold ml-1",
          variant === 'blue' ? "text-primary" : "text-destructive"
        )}
      >
        ({team.length})
      </span>
    </div>
  );
};
